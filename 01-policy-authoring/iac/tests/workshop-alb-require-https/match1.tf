resource "aws_alb_listener" "http" {
  load_balancer_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my_alb"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
