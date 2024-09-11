
# VPC Module -------------------------


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.region}-${var.env}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false
  one_nat_gateway_per_az = false

  enable_vpn_gateway = false

  map_public_ip_on_launch = true    
  enable_dns_hostnames = true
  enable_dns_support = true

}

# Application Load Balancer -------------------------

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

# EC2 Instance -------------------------


module "ec2_instance" {
  source = "../../../modules/ec2_instance"

    ami_id = var.windows_ami_ids["windows2022"]
    instance_type = "t2.micro"
    private_subnet = module.vpc.private_subnets[0]
    user_data_file_path = "${path.module}/launchscript.ps1"
    security_group = [aws_security_group.alb.id]
    instance_name = "${var.region}-${var.env}-webserver"

    depends_on = [ aws_security_group.alb ]
}
# S3 Bucket -------------------------

module "s3_bucket" {
  source  = "../../../modules/s3_bucket"

  bucket_name = "${var.region}-${var.env}-bucket"
  ec2_instance_role_arn = module.ec2_instance.instance_role.arn

  depends_on = [ module.ec2_instance ]
}
