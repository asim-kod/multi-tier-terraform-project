################################################################################
# Load Balancer
################################################################################
output "alb_id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.id
}

output "alb_arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.alb.arn
}

output "alb_arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.alb.arn_suffix
}

output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.alb.zone_id
}

################################################################################
# Listener(s)
################################################################################
output "listeners" {
  description = "Map of listeners created and their attributes"
  value       = module.alb.listeners
  sensitive   = true
}

output "listener_rules" {
  description = "Map of listeners rules created and their attributes"
  value       = module.alb.listener_rules
  sensitive   = true
}

################################################################################
# Target Group(s)
################################################################################
# output "target_groups" {
#   description = "Map of target groups created and their attributes"
#   value       = module.alb.target_groups
# }

output "app1_tg_arn" {
  description = "ARN of the App1 target group"
  value       = module.alb.target_groups["app1"].arn
}

output "app1_tg_arn_suffix" {
  description = "ARN suffix of the App1 target group"
  value       = module.alb.target_groups["app1"].arn_suffix
}

output "app2_tg_arn" {
  description = "ARN of the App2 target group"
  value       = module.alb.target_groups["app2"].arn
}

output "app2_tg_arn_suffix" {
  description = "ARN suffix of the App2 target group"
  value       = module.alb.target_groups["app2"].arn_suffix
}
