vpc_enabled           = true
cidr_block            = "10.0.0.0/16"
vpc_name              = "my-vpc"
public_subnets        = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets       = ["10.0.11.0/24", "10.0.12.0/24"]
azs                   = ["us-east-1a", "us-east-1b"]

enable_internet_gateway = true
enable_nat_gateway      = true
enable_route_tables     = true
enable_vpn_gateway      = false

tags = {
  Environment = "dev"
  Project     = "example"
}

existing_vpc_id            = "vpc-0123456789abcdef0"         # required if vpc_enabled = false
existing_private_subnet_ids = ["subnet-aaa111", "subnet-bbb222"] # if vpc_enabled = false
existing_default_sg_id      = "sg-0123456789abcdef0"           # if vpc_enabled = false

efs_enabled                    = false
efs_name                       = "my-efs"
efs_encrypted                 = false

db_enabled                    = true
db_identifier                 = "mydb-instance"
db_engine                     = "sqlserver-se"
db_engine_version             = "15.00.4073.23.v1"
db_instance_class            = "db.m5.large"
db_storage_type              = "gp2"
db_allocated_storage          = 100
allow_major_version_upgrade   = false

db_name                      = "mydatabase"
db_username                  = "adminuser"
db_password                  = "SuperSecretPass123!"
db_port                      = 1433

iam_auth_enabled             = false

maintenance_window           = "Sun:23:00-Sun:23:30"
backup_window               = "03:00-06:00"

monitoring_interval          = 60
monitoring_role_name         = ""
create_monitoring_role       = false

create_db_subnet_group       = true
db_family                   = "sqlserver-se-15"
db_major_engine_version     = "15"
db_deletion_protection      = false

db_parameters               = {}
db_options                  = {}

