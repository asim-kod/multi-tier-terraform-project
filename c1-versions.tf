# Terraform Block
terraform {
  required_version = "~> 1.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.7"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0.0"
    }
  }
}

# Provider Block
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}