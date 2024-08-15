
# VPC Module

# The VPC Module is a good example why to separate states of different environments. For example, this VPC has a NAT Gateway in each AZ
# While the VPC in a TEST environment does not require such high availability / fault tolerance !

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.region}-${var.env}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  enable_vpn_gateway = false

  map_public_ip_on_launch = true    
  enable_dns_hostnames = true
  enable_dns_support = true

}

# EC2 Instance -------------------------

data "aws_iam_role" "ec2_instance_role" {
  name = "ec2_s3_access_role"
}

module "ec2_instance" {
  source = "../../../modules/ec2_instance"

    ami_id = var.windows_ami_ids["windows2022"]
    instance_type = "t2.micro"
    private_subnet = module.vpc.private_subnets[0]
    user_data_file_path = "${path.module}/launchscript.ps1"
    webserver_role = data.aws_iam_role.ec2_instance_role.name
    alb_security_group = [aws_security_group.alb.id]

    depends_on = [ aws_security_group.alb ]
}

# Application Load Balancer -------------------------

# For the Application Load Balancer we need a Security Group, but to avoid circular dependencies with the EC2 instance, I will create the SG here.
# In the lines above, the EC2 requires a security group to be provided for secure access between the ALB and the EC2

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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = {
    Name = "${var.region}-${var.env}-alb"
  }
}

# ALB Module
module "alb" {
  source = "../../../modules/alb"

  name = "${var.region}-${var.env}"
  security_group_id = aws_security_group.alb.id
  public_subnets_ids = module.vpc.public_subnets
  instance_id = module.ec2_instance.instance_id
  vpc_id = module.vpc.vpc_id
  certificate_arn = "arn:aws:acm:us-east-1:988015658873:certificate/e6ad9d75-356c-44cb-878b-6405402c1d0a"
  
  depends_on = [ module.ec2_instance, module.vpc ]
}