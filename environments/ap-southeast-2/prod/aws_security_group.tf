# For the Application Load Balancer we need a Security Group, but to avoid circular dependencies with the EC2 instance, it will be created here.
# The EC2 module requires this security group to be provided for secure access between the ALB and the EC2

# Security Group for ALB
resource "aws_security_group" "alb" {
  name        = "${var.region}-${var.env}-alb"
  description = "Security Group for Application Load Balancer"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.region}-${var.env}-alb"
  }
}