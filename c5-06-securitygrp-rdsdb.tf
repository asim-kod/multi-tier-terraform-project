module "rdsdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "rdsdb-sg"
  description = "access to MySQL DB for entire vpc cidr block"
  vpc_id      = module.vpc.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_with_cidr_blocks = [
    {
      description = "MySQL access from within vpc"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ]

  # Egress Rules - all open
  egress_rules = ["all-all"]

  tags = local.common_tags
}