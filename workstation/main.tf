module "account_setup" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/account-setup?ref=eks"
  count         = var.enable_account_setup ? 1 : 0
  account_name  = var.account_name
  account_email = var.account_email
}

module "vpc" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/vpc?ref=eks"
  count                = var.enable_vpc ? 1 : 0
  name                 = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  tags                 = var.tags
}

module "security_groups" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/security-groups?ref=eks"
  count         = var.enable_eks ? 1 : 0
  name          = var.vpc_name
  vpc_id        = module.vpc[0].vpc_id
  node_cidrs    = [var.vpc_cidr]
  cluster_cidrs = [var.vpc_cidr]
  tags          = var.tags
}

module "iam" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/iam?ref=eks"
  count  = var.enable_eks ? 1 : 0
  name  = var.cluster_name
  tags  = var.tags
}

module "eks" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/eks?ref=eks"
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
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/eks-fargate?ref=eks"
  count                 = var.enable_fargate ? 1 : 0
  name                  = var.cluster_name
  cluster_name          = module.eks[0].cluster_name
  private_subnet_ids    = module.vpc[0].private_subnets
  namespace             = var.fargate_namespace
  tags                  = var.tags
}


module "alb_ingress" {
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/alb-ingress?ref=eks"
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
  source        = "git@github.com:advantagecg/tf-blueprint.git//modules/ecr?ref=eks"
  count            = var.enable_ecr ? 1 : 0
  repository_names = var.repository_names
  scan_on_push     = var.scan_on_push
  tag_mutability   = var.tag_mutability
  tags             = var.tags
}
