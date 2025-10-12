module "app1_asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.0.1"

  depends_on = [module.alb]

  # Autoscaling group
  name            = "${local.environment}-app1-asg"
  use_name_prefix = false
  instance_name   = "${local.environment}-app1"

  ignore_desired_capacity_changes = true

  min_size                  = 2
  max_size                  = 5
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  default_instance_warmup   = 300
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.vpc.private_subnets

  # Traffic source attachment
  traffic_source_attachments = {
    ex-alb = {
      traffic_source_identifier = module.alb.target_groups["app1"].arn
      traffic_source_type       = "elbv2" # default
    }
  }

  initial_lifecycle_hooks = [
    {
      name                 = "ExampleStartupLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 60
      lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "hello" = "world" })
    },
    {
      name                 = "ExampleTerminationLifeCycleHook"
      default_result       = "CONTINUE"
      heartbeat_timeout    = 180
      lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
      # This could be a rendered data resource
      notification_metadata = jsonencode({ "goodbye" = "world" })
    }
  ]

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay             = 600
      checkpoint_percentages       = [35, 70, 100]
      instance_warmup              = 300
      min_healthy_percentage       = 50
      max_healthy_percentage       = 100
      auto_rollback                = true
      scale_in_protected_instances = "Refresh"
      standby_instances            = "Terminate"
      skip_matching                = false
    }
    triggers = ["tag", "desired_capacity"]
  }

  instance_maintenance_policy = {
    min_healthy_percentage = 100 # 100 means no instance is terminated until a new healthy one is in service.
    max_healthy_percentage = 110 # 110 means the ASG can temporarily go 10% above desired capacity during update.
  }

  # Launch template
  launch_template_name        = "${local.environment}-app1-lt"
  launch_template_description = "app1 launch template"
  image_id                    = data.aws_ami.amzlinux.id
  instance_type               = var.instance_type

  # Security group is set on the ENIs below
  security_groups = [module.private_sg.security_group_id]

  key_name               = var.instance_keypair
  user_data              = filebase64("${path.module}/app1-install.sh")
  ebs_optimized          = true
  update_default_version = true
  enable_monitoring      = true

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = 8
        volume_type           = "gp2"
      }
    }
  ]

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
    instance_metadata_tags      = "enabled"
  }

  credit_specification = {
    cpu_credits = "standard" # default
  }

  maintenance_options = {
    auto_recovery = "default"
  }

  tags = local.common_tags

  # Target scaling policy schedule based on average CPU load
  scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 180
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    },
    request-count-per-target = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 120
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ALBRequestCountPerTarget"
          resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["app1"].arn_suffix}"
        }
        target_value = 10
      }
    }
  }

  # # Autoscaling Schedule
  # schedules = {
  #   night = {
  #     min_size         = 0
  #     max_size         = 0
  #     desired_capacity = 0
  #     recurrence       = "0 18 * * 1-5" # Mon-Fri in the evening
  #     time_zone        = "Europe/Rome"
  #   }

  #   morning = {
  #     min_size         = 0
  #     max_size         = 1
  #     desired_capacity = 1
  #     recurrence       = "0 7 * * 1-5" # Mon-Fri in the morning
  #   }

  #   go-offline-to-celebrate-new-year = {
  #     min_size         = 0
  #     max_size         = 0
  #     desired_capacity = 0
  #     start_time       = "2031-12-31T10:00:00Z" # Should be in the future
  #     end_time         = "2032-01-01T16:00:00Z"
  #   }
  # }
}