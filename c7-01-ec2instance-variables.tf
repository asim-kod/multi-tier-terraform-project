# Instance Type
variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

# Key Pair
variable "instance_keypair" {
  description = "ec2 key pair that need to associated with ec2 instance"
  type        = string
  default     = "NVirginia_key"
}

variable "subnet_ids" {
  description = "The VPC Subnet IDs to launch in"
  type        = list(string)
  default     = null
}

# Private Instance Count
variable "private_instance_count" {
  description = "private instances count"
  type        = number
  default     = 1
}