################################################################################
# App1 asg Outputs
################################################################################
output "app1_asg_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.app1_asg.launch_template_id
}

output "app1_asg_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.app1_asg.launch_template_latest_version
}

output "app1_asg_id" {
  description = "The autoscaling group id"
  value       = module.app1_asg.autoscaling_group_id
}

output "app1_asg_group_name" {
  description = "The autoscaling group name"
  value       = module.app1_asg.autoscaling_group_name
}

################################################################################
# App2 asg Outputs
################################################################################
output "app2_asg_launch_template_id" {
  description = "The ID of the launch template"
  value       = module.app2_asg.launch_template_id
}

output "app2_asg_launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.app2_asg.launch_template_latest_version
}

output "app2_asg_id" {
  description = "The autoscaling group id"
  value       = module.app2_asg.autoscaling_group_id
}

output "app2_asg_group_name" {
  description = "The autoscaling group name"
  value       = module.app2_asg.autoscaling_group_name
}