################################################################################
# VPC ID
################################################################################
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

################################################################################
# VPC CIDR Block
################################################################################
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

################################################################################
# Private Subnets
################################################################################
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

################################################################################
# Public Subnets
################################################################################
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

################################################################################
# Nat Gateway Public IP
################################################################################
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

################################################################################
# AZs Lists
################################################################################
output "vpc_azs" {
  description = "list of azs"
  value       = module.vpc.azs
}