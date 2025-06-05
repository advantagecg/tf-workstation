variable "vpc_enabled" {
  type    = bool
  default = true
}

variable "cidr_block" {
  type = string
}
variable "profile" {
  
}
variable "region" {
  
}

variable "vpc_name" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "enable_internet_gateway" {
  type    = bool
  default = true
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "enable_route_tables" {
  type    = bool
  default = true
}

variable "enable_vpn_gateway" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "existing_vpc_id" {
  type    = string
  default = ""
}

variable "existing_private_subnet_ids" {
  type    = list(string)
  default = []
}

variable "existing_default_sg_id" {
  type    = string
  default = ""
}

variable "efs_enabled" {
  type    = bool
  default = false
}

variable "efs_name" {
  type = string
}

variable "efs_encrypted" {
  type    = bool
  default = false
}

variable "efs_performance_mode" {
  type    = string
  default = "generalPurpose"
}

variable "efs_throughput_mode" {
  type    = string
  default = "bursting"
}

variable "efs_provisioned_throughput_in_mibps" {
  type    = number
  default = 0
}

variable "efs_attach_policy" {
  type    = bool
  default = false
}

variable "efs_policy_statements" {
  type    = list(any)
  default = []
}

variable "efs_tags" {
  type    = map(string)
  default = {}
}

variable "db_enabled" {
  type    = bool
  default = false
}

variable "db_identifier" {
  type = string
}

variable "db_engine" {
  type    = string
  default = "sqlserver-se" # MSSQL Standard edition as example
}

variable "db_engine_version" {
  type    = string
  default = "15.00.4073.23.v1" # example version
}

variable "db_instance_class" {
  type    = string
  default = "db.m5.large"
}

variable "db_storage_type" {
  type    = string
  default = "gp2"
}

variable "db_allocated_storage" {
  type    = number
  default = 100
}

variable "allow_major_version_upgrade" {
  type    = bool
  default = false
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "db_port" {
  type    = number
  default = 1433
}

variable "iam_auth_enabled" {
  type    = bool
  default = false
}

variable "maintenance_window" {
  type    = string
  default = "Sun:23:00-Sun:23:30"
}

variable "backup_window" {
  type    = string
  default = "03:00-06:00"
}

variable "monitoring_interval" {
  type    = number
  default = 60
}

variable "monitoring_role_name" {
  type    = string
  default = ""
}

variable "create_monitoring_role" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "create_db_subnet_group" {
  type    = bool
  default = true
}

variable "db_family" {
  type    = string
  default = "sqlserver-se-15"
}

variable "db_major_engine_version" {
  type    = string
  default = "15"
}

variable "db_deletion_protection" {
  type    = bool
  default = false
}

variable "db_parameters" {
  type    = map(string)
  default = {}
}

variable "db_options" {
  type    = map(string)
  default = {}
}
