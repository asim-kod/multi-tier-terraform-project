# Providers 
variable "aws_region" {
  description = "region in which aws resources will be created"
  type        = string
  default     = "us-east-1"
}

# Profile
variable "aws_profile" {
  description = "profile by which terraform will get access to aws"
  type        = string
  default     = "terraform"
}

# Environment 
variable "environment" {
  description = "environment variable used as a prefix"
  type        = list(string)
  default     = ["dev", "test", "stage", "prod"]
}

# Business Division
variable "business_division" {
  description = "business division in the large organization this Infrastructure belongs"
  type        = list(string)
  default     = ["hr", "finance", "it", "engineering", "sales", "marketing", "legal", "operations"]
}

############
## INFO ##
############
# hr = Human Resources (recruitment, payroll, etc.)
# finance = Financial operations, accounting, budgeting
# it = Information Technology (infra, helpdesk, etc.)
# engineering = Software/product development teams
# sales = Sales teams, CRM, pipeline management
# marketing = Marketing, branding, lead gen
# legal = Legal compliance, contracts, etc.
# operations = Day-to-day operations, logistics
# admin = Administrative tasks and office management
# procurement = Purchasing and vendor management
# security = Cybersecurity or physical security teams
# product = Product management teams
# support = Customer support / tech support
# research = R&D teams
# training = Internal or external training departments 

