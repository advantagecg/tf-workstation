variable "aws_region" {
  type        = string
  default     = "us-west-2"
}

variable "aws_profile" {
  type        = string
  default     = "default"
}

# Toggles
variable "enable_account_setup" {
  type        = bool
  default     = false
}

variable "enable_vpc" {
  type        = bool
  default     = true
}

variable "enable_eks" {
  type        = bool
  default     = true
}

variable "enable_fargate" {
  type        = bool
  default     = false
}

variable "enable_alb_ingress" {
  type        = bool
  default     = true
}

variable "enable_ecr" {
  type        = bool
  default     = true
}

# Account Setup
variable "account_name" {
  type = string
}

variable "account_email" {
  type = string
}

# VPC
variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

# EKS
variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "eks_min_size" {
  type = number
}

variable "eks_max_size" {
  type = number
}

variable "eks_desired_capacity" {
  type = number
}

variable "ssh_key_name" {
  type = string
}

# Fargate
variable "fargate_namespace" {
  type = string
}

# ALB Ingress
variable "alb_namespace" {
  type    = string
  default = "kube-system"
}

variable "alb_service_account_name" {
  type    = string
  default = "aws-load-balancer-controller"
}

# ECR
variable "repository_names" {
  type = list(string)
}

variable "scan_on_push" {
  type    = bool
  default = true
}

variable "tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

# Tags
variable "tags" {
  type = map(string)
}
