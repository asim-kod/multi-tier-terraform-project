################################################################################
# Public EC2 Instances 
################################################################################
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip
}

output "ec2_ami_id" {
  description = "ami id of instances"
  value       = data.aws_ami.amzlinux.id
}