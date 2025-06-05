# Account module variables
new_account_is_enabled  = true
name_account            = "myaccount"
email_account           = "admin@example.com"
account_env             = "dev"
account_team            = "dev-team"
new_account_user_name   = "adminuser"
region                  = "us-east-1"

# VPC module variables
vpc_enabled             = true
cidr_block              = "10.0.0.0/16"
vpc_name                = "my-vpc"
public_subnets          = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets         = ["10.0.101.0/24", "10.0.102.0/24"]
azs                     = ["us-east-1a", "us-east-1b"]
enable_internet_gateway = true
enable_nat_gateway      = true
enable_route_tables     = true
enable_vpn_gateway      = false
tags = {
  Environment = "dev"
  Project     = "my-project"
}

# EFS module variables
efs_enabled                    = true
efs_name                       = "my-efs"
efs_encrypted                  = true
efs_performance_mode           = "generalPurpose"
efs_throughput_mode            = "bursting"
efs_provisioned_throughput_in_mibps = 0
efs_attach_policy              = true
efs_policy_statements          = []  # fill if any IAM policy statements required
efs_subnet_ids                 = ["subnet-0abc1111", "subnet-0abc2222"]  # private subnet IDs in VPC
efs_security_group_ids         = ["sg-0123456789abcdef0"]
efs_tags = {
  Environment = "dev"
  Project     = "my-project"
}

# DB module variables (MSSQL specific)
db_enabled                    = true
db_identifier                 = "my-mssql-instance"
db_engine                    = "sqlserver-se"
db_engine_version            = "15.00.4236.7.v1"  # AWS supported version
db_instance_class            = "db.m5.large"
db_storage_type              = "gp2"
db_allocated_storage         = 50
allow_major_version_upgrade  = false

db_name                     = "mydatabase"
db_username                 = "adminuser"
db_password                 = "supersecretpassword"
db_port                     = 1433

iam_auth_enabled            = false
vpc_security_group_ids      = ["sg-0123456789abcdef0"]  # same as used by EFS or VPC default SG if needed
maintenance_window          = "sun:23:00-mon:01:30"
backup_window              = "03:00-06:00"
monitoring_interval        = 60
monitoring_role_name       = ""
create_monitoring_role     = false

tags = {
  Environment = "dev"
  Project     = "my-project"
}

create_db_subnet_group = true
subnet_ids             = ["subnet-0abc1111", "subnet-0abc2222"]  # private subnet IDs

db_family               = "sqlserver-se-15"
db_major_engine_version = "15"
db_deletion_protection  = false

db_parameters = {
  "max_degree_of_parallelism" = "4"
  "backup_retention_period"   = "7"
}

db_options = {}
