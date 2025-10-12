# DB Instance Identifier
variable "db_instance_identifier" {
  description = "rds database insatance identifier"
  type        = string
}

# DB Name
variable "db_name" {
  description = "rds database name"
  type        = string
}

# DB Username
variable "db_username" {
  description = "rds database admin username"
  type        = string
  sensitive   = true
}

# DB Password
variable "db_password" {
  description = "rds database admin password"
  type        = string
  sensitive   = true
}