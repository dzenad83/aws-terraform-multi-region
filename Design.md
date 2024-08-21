# Design Decisions

The Terraform code repository consists of six states, corresponding to the six mentioned environments. The proposed folder structure best reflects my approach. The reason for separating the six states is to accommodate potential specific differences in each environment in the future.

Hashicorpt's Terraform Cloud has been chosen to keep the states, and to act as a CI CD tool.

```

The current folder structure supporting all environments and regions:

modules/
environments/
├── ap-southeast-2/
│   ├── test/
│   └── prod/
├── eu-west-2/
│   ├── test/
│   └── prod/
└── us-east-1/
    ├── test/
    └── prod/
```

The main.tf file serves as the root module for Terraform in every environment, so everything in the environment should start from there. Even though there are additional files in each environment that create resources such as security groups and IAM-related resources. These resources are defined here to avoid circular dependencies within the EC2 and S3 bucket modules.

Regarding the AWS diagram, I illustrated what I understood from the assignment's text. This diagram essentially represents what I have created in the Terraform code. The Application Load Balancer (ALB) serves as the public endpoint, secured with a security group that allows traffic only on ports 80 and 443, with port 80 being redirected to 443. I used an SSL certificate that I had already created. Unfortunately, I didn’t have a domain to create a DNS record pointing to the Load Balancer, but that can be easily done. I would then use host-based or path-based routing to direct traffic to different targets. Since there was only one instance and I didn’t have the domain, the SSL certificate will show a warning. However, the intention was to demonstrate how the ALB should be configured and how SSL/TLS termination should be handled.

The ALB is the only component exposed in a Public Subnet, while the EC2 instance is in a Private Subnet. Access to the private instance is not possible without some kind of JumpHost or VPN solution that will enable administrators. While deployments to the EC2 instance are possible through any CI tool that is running within the VPC. 
Behind the ALB, the EC2 instance is running Windows and has a security group that only allows traffic from the Load Balancer’s security group. All data coming through the ALB will be routed ingress and egress through the ALB (the EC2 instance will responde through it). The EC2 instance includes a user_data PowerShell script (launchscrpt.ps1) that installs .NET 8, creates a Hello World application in IIS, and opens port 80 on the Windows Firewall. This setup should enable traffic to reach the instance and show a simple app, as the Load Balancer forwards traffic on port 80.

The S3 buckets are created only in region us-east-1. When I call the S3 Bucket module, I pass the the region parameters with the aws provider.

```
  providers = {
    aws = aws.us_east_1
  }
```

The S3 bucket has encryption at rest, it has a bucket policy that allows only the IAM role access, and the IAM role is attached to the EC2 Instance Profile for each instance.

Note: There is always place for discussion, improvements, and different views and opinions. This is just one way to do it.
