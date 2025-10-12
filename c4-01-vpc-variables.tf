# VPC Name
variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "myvpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

# AZs
variable "vpc_availability_zones" {
  description = "vpc availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# Public Subnets
variable "vpc_public_subnets" {
  description = "vpc public subnet"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# Private Subnets
variable "vpc_private_subnets" {
  description = "vpc private subnet"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Default Route Table
variable "vpc_default_route_table" {
  description = "default route table"
  type        = bool
  default     = false
}

# Default Security Group
variable "vpc_default_security_group" {
  description = "default security group"
  type        = bool
  default     = false
}

# Default Network Acl
variable "vpc_default_network_acl" {
  description = "default Network Acl"
  type        = bool
  default     = true
}

# Database Subnets
variable "vpc_database_subnets" {
  description = "vpc database subnet"
  type        = list(string)
  default     = ["10.0.151.0/24", "10.0.152.0/24"]
}

# Create Database Subnet Group
variable "vpc_create_database_subnet_group" {
  description = "vpc create database subnet group"
  type        = bool
  default     = true
}

# Create Database Subnet Route Table
variable "vpc_create_database_subnet_route_table" {
  description = "vpc create database subnet route table"
  type        = bool
  default     = true
}

# Enable NAT Gateway
variable "vpc_enable_nat_gateway" {
  description = "enable nat gateway for private subnets outbount connection"
  type        = bool
  default     = true
}

# Single NAT Gateway
variable "vpc_single_nat_gateway" {
  description = "enable only one nat gateway in on AZ"
  type        = bool
  default     = true
}

