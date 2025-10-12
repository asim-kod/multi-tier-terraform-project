# Security Group for Private EC2 Instance
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "private-sg"
  description = "security group with ssh and http port open for entire vpc block"
  vpc_id      = module.vpc.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rules - all open
  egress_rules = ["all-all"]

  tags = local.common_tags
}