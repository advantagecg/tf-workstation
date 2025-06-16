terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "account_setup" {
  source        = "./modules/account-setup"
  count         = var.enable_account_setup ? 1 : 0
  account_name  = var.account_name
  account_email = var.account_email
}

module "vpc" {
  source               = "./modules/vpc"
  count                = var.enable_vpc ? 1 : 0
  name                 = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "security_groups" {
  source        = "./modules/security-groups"
  count         = var.enable_eks ? 1 : 0
  name          = var.vpc_name
  vpc_id        = module.vpc[0].vpc_id
  node_cidrs    = [var.vpc_cidr]
  cluster_cidrs = [var.vpc_cidr]
  tags          = var.tags
}

module "iam" {
  source = "./modules/iam"
  count  = var.enable_eks ? 1 : 0
}

module "eks" {
  source              = "./modules/eks"
  count               = var.enable_eks ? 1 : 0
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  cluster_role_arn    = module.iam[0].eks_cluster_role_arn
  node_role_arn       = module.iam[0].eks_node_role_arn
  subnet_ids_private  = module.vpc[0].private_subnets
  cluster_sg_id       = module.security_groups[0].eks_cluster_sg_id
  instance_types      = var.instance_types
  min_capacity        = var.eks_min_size
  max_capacity        = var.eks_max_size
  desired_capacity    = var.eks_desired_capacity
  ssh_key_name        = var.ssh_key_name
}

module "eks_fargate" {
  source                = "./modules/eks-fargate"
  count                 = var.enable_fargate ? 1 : 0
  name                  = var.cluster_name
  cluster_name          = module.eks[0].cluster_name
  private_subnet_ids    = module.vpc[0].private_subnets
  namespace             = var.fargate_namespace
  tags                  = var.tags
}

module "eks_oidc" {
  source = "./modules/oidc"
  count  = var.enable_eks ? 1 : 0
  cluster_name = module.eks[0].cluster_name
}

module "alb_ingress" {
  source               = "./modules/alb-ingress"
  count                = var.enable_alb_ingress ? 1 : 0
  cluster_name         = module.eks[0].cluster_name
  region               = var.aws_region
  vpc_id               = module.vpc[0].vpc_id
  oidc_provider_arn    = module.eks_oidc[0].oidc_provider_arn
  oidc_provider_url    = module.eks_oidc[0].oidc_provider_url
  namespace            = var.alb_namespace
  service_account_name = var.alb_service_account_name
  tags                 = var.tags
}

module "ecr" {
  source           = "./modules/ecr"
  count            = var.enable_ecr ? 1 : 0
  repository_names = var.repository_names
  scan_on_push     = var.scan_on_push
  tag_mutability   = var.tag_mutability
  tags             = var.tags
}
