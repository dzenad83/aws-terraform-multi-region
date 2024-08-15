# Application Load Balancer Resource
resource "aws_lb" "this" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnets_ids

  tags = {
    Name        = "${lower(var.name)}"
  }
}

# Target Group for EC2
resource "aws_lb_target_group" "this" {
  name        = "${var.name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc_id
}

# Attaching the EC2 instance to the Target Group
resource "aws_lb_target_group_attachment" "tg-attach" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_id
  port             = 80
}

# HTTPS Listener on ALB
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

#HTTP Listener and Redirect
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
      host        = "#{host}"
      path        = "/#{path}"
      query       = "#{query}"
    }
  }
}