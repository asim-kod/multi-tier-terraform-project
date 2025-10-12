module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"

  name                   = "${local.environment}-BastionHost"
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.public_bastion_sg.security_group_id]
  user_data              = file("${path.module}/bastionhost-install.sh")
  tags                   = local.common_tags
}