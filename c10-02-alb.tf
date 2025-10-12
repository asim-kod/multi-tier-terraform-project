module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name                       = "${local.environment}-alb"
  load_balancer_type         = "application" # If not mentioned then it will auto select application lb
  vpc_id                     = module.vpc.vpc_id
  enable_deletion_protection = false # If ture then trun off manually from console before terraform destroy

  subnets = module.vpc.public_subnets

  create_security_group = false # No need if you have created security groups manually
  security_groups       = [module.loadbalancer_sg.security_group_id]

  # Target Groups
  target_groups = {

    # App1 TG
    app1 = {
      name_prefix       = "app1-"
      protocol          = "HTTP"
      port              = 80
      target_type       = "instance"
      create_attachment = false
      # target_id            = module.ec2_private_app1.id[0]
      deregistration_delay = 10

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      tags             = local.common_tags
    }

    # App2 TG
    app2 = {
      name_prefix       = "app2-"
      protocol          = "HTTP"
      port              = 8080
      target_type       = "instance"
      create_attachment = false
      # target_id            = module.ec2_private_app2.id[0]
      deregistration_delay = 10

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/student-login"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"

      stickiness = {
        enabled         = true
        cookie_duration = 86400 # seconds (1 day)
        type            = "lb_cookie"
      }

      tags = local.common_tags
    }
  }

  # Listeners Rules
  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static Message"
        status_code  = 200
      }

      rules = {

        # app1 path rule
        app1_path = {
          priority   = 1
          actions    = [{ type = "forward", target_group_key = "app1" }]
          conditions = [{ path_pattern = { values = ["/app1*"] } }]
        }

        # app2 path rule
        app2_path = {
          priority   = 2
          actions    = [{ type = "forward", target_group_key = "app2" }]
          conditions = [{ path_pattern = { values = ["/student-login*"] } }]
        }
      }
    }
  }

  tags = local.common_tags
}