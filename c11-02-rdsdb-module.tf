module "rdsdb" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  identifier = var.db_instance_identifier

  engine               = "mariadb"
  engine_version       = "11.4.5"
  family               = "mariadb11.4"
  major_engine_version = "11.4"
  instance_class       = "db.t4g.micro"

  allocated_storage     = 20
  max_allocated_storage = 20

  # DB Settings
  db_name                     = var.db_name # Initial database name
  username                    = var.db_username
  password                    = var.db_password
  manage_master_user_password = false
  port                        = "3306"

  # Standby settings
  multi_az = false

  # Networking
  create_db_subnet_group = true
  db_subnet_group_name   = "${var.db_instance_identifier}-subnet-group"
  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = [module.rdsdb_sg.security_group_id]

  # Database Deletion Protection
  deletion_protection = false
  skip_final_snapshot = true

  # Custom option & parameter groups
  create_db_option_group    = false
  create_db_parameter_group = false

  create_monitoring_role = false

  backup_retention_period    = 0     # For 0 days retention or disable "automated backups"
  storage_encrypted          = false # Specifies whether the DB instance is encrypted
  auto_minor_version_upgrade = false # Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window

  tags = local.common_tags
}