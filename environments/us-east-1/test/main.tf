
# VPC Module

# The VPC Module is a good example why to separate states of different environments. For example, this VPC has a NAT Gateway in each AZ
# While the VPC in a TEST environment does not require such high availability / fault tolerance !

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.region}-${var.env}"
  cidr = "10.1.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  enable_vpn_gateway = false

  map_public_ip_on_launch = true    
  enable_dns_hostnames = true
  enable_dns_support = true

}