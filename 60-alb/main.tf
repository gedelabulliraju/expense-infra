
module "ingress_alb" { # application load balancer
  source = "terraform-aws-modules/alb/aws"

  internal = false
  name    = "${local.resource_name}-ingress-alb" #expense-dev-app-alb
  vpc_id  = local.vpc_id
  subnets = local.public_subnet_ids
  security_groups = [data.aws_ssm_parameter.ingress_alb_sg_id.value]
  create_security_group = false
  enable_deletion_protection = false
  tags = merge(
    var.common_tags,
    var.ingress_alb_tags
  )
}

resource "aws_lb_listener" "http" { # listener for ALB
  load_balancer_arn = module.ingress_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Application ALB</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https" { # listener for ALB
  load_balancer_arn = module.ingress_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.https_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from Web ALB HTTPS</h1>"
      status_code  = "200"
    }
  }
}


# module "records" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 2.0"

#   zone_name = var.zone_name #calculatorss.online
#   records = [
#     {
#       name    = "expense-${var.environment}" # *.app-dev
#       type    = "A"
#       alias   = {
#         name    = module.ingress_alb.dns_name
#         zone_id = module.ingress_alb.zone_id # This belongs ALB internal hosted zone, not ours
#       }
#       allow_overwrite = true
#     }
#   ]
# }
resource "aws_route53_record" "ingress_alb" { # Route53 record for ALB
  zone_id = data.aws_route53_zone.expense.zone_id
  name    = "expense-${var.environment}" #expense-dev
  type    = "A"
  allow_overwrite = true

  alias {
    # These are ALB details, not our domain details
    name                   = module.ingress_alb.dns_name
    zone_id                = module.ingress_alb.zone_id
    evaluate_target_health = true
  }
}
resource "aws_lb_target_group" "expense" { # target group for ALB
  name     = local.resource_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 5
    matcher = "200-299"
    path = "/"
    port = 80
    protocol = "HTTP"
    timeout = 4
  }
}

resource "aws_lb_listener_rule" "frontend" { # listener rule for ALB
  listener_arn = aws_lb_listener.https.arn # attach to HTTPS listener
  priority     = 100 # low priority will be evaluated first

  action { # forward to target group
    type             = "forward" # forward to target group
    target_group_arn = aws_lb_target_group.expense.arn # target group ARN
  }

  condition { # host header condition
    host_header {
      values = ["expense-${var.environment}.${var.zone_name}"] #expense-dev.calculatorss.online
    }
  }
}
