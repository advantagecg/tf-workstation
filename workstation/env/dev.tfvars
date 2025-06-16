aws_region         = "us-west-2"
aws_profile        = "dev"

enable_account_setup = true
enable_vpc           = true
enable_eks           = true
enable_fargate       = false
enable_alb_ingress   = true
enable_ecr           = true

account_name         = "dev-account"
account_email        = "dev-team@example.com"

vpc_name             = "eks-dev-vpc"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones   = ["us-west-2a", "us-west-2b"]

cluster_name         = "eks-dev"
kubernetes_version   = "1.29"
instance_types       = ["t3.medium"]
eks_min_size         = 1
eks_max_size         = 2
eks_desired_capacity = 2
ssh_key_name         = "eks-dev-key"

fargate_namespace = "default"

alb_namespace            = "kube-system"
alb_service_account_name = "aws-load-balancer-controller"

repository_names = ["web-app", "worker-app", "nginx-proxy"]
scan_on_push     = true
tag_mutability   = "IMMUTABLE"

tags = {
  Environment = "dev"
  Project     = "agc"
}
