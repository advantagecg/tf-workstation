module "create_new_account" {
  source = "git@github.com:advantagecg/tf-blueprint.git//modules/accounts?ref=master"

  new_account_is_enabled  = var.new_account_is_enabled
  name_account            = var.name_account
  email_account           = var.email_account
  account_env             = var.account_env
  account_team            = var.account_team
  new_account_user_name   = var.new_account_user_name
  region                  = var.region
}
module "vpc" {
  source = "git@github.com:advantagecg/tf-blueprint.git//modules/vpc?ref=master"
  count  = var.vpc_enabled ? 1 : 0
  cidr_block              = var.cidr_block
  vpc_name                = var.vpc_name
  public_subnets          = var.public_subnets
  private_subnets         = var.private_subnets
  azs                     = var.azs
  enable_internet_gateway = var.enable_internet_gateway
  enable_nat_gateway      = var.enable_nat_gateway
  enable_route_tables     = var.enable_route_tables
  enable_vpn_gateway      = var.enable_vpn_gateway
  tags                    = var.tags
}
module "efs" {
  source  = "git@github.com:advantagecg/tf-blueprint.git//modules/efs?ref=master"
  count  = var.efs_enabled ? 1 : 0
  name                             = var.efs_name
  encrypted                        = var.efs_encrypted
  performance_mode                 = var.efs_performance_mode
  throughput_mode                  = var.efs_throughput_mode
  provisioned_throughput_in_mibps = var.efs_provisioned_throughput_in_mibps
  attach_policy                    = var.efs_attach_policy
  policy_statements                = var.efs_policy_statements
  mount_targets = {
    for az, subnet_id in var.efs_subnet_ids :
    az => {
      subnet_id       = subnet_id
      security_groups = var.efs_security_group_ids
    }
  }
  tags = var.efs_tags
}


module "db" {
  source  = "git@github.com:advantagecg/tf-blueprint.git//modules/rds?ref=master"
  count  = var.db_enabled ? 1 : 0

  identifier                          = var.db_identifier
  engine                              = var.db_engine
  engine_version                      = var.db_engine_version
  instance_class                      = var.db_instance_class
  storage_type                        = var.db_storage_type
  allocated_storage                   = var.db_allocated_storage
  allow_major_version_upgrade         = var.allow_major_version_upgrade

  db_name                             = var.db_name
  username                            = var.db_username
  password                            = var.db_password
  port                                = var.db_port

  iam_database_authentication_enabled = var.iam_auth_enabled
  vpc_security_group_ids              = var.vpc_security_group_ids

  maintenance_window                  = var.maintenance_window
  backup_window                       = var.backup_window

  monitoring_interval                 = var.monitoring_interval
  monitoring_role_name                = var.monitoring_role_name
  create_monitoring_role              = var.create_monitoring_role

  tags                                = var.tags

  create_db_subnet_group              = var.create_db_subnet_group
  subnet_ids                          = var.subnet_ids

  family                              = var.db_family
  major_engine_version                = var.db_major_engine_version
  deletion_protection                 = var.db_deletion_protection

  parameters                          = var.db_parameters
  options                             = var.db_options
}


