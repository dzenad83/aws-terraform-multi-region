MULTIREGION MULTIENVIRONMENT DEPLOYMENT 


The Challenge: You are tasked to set up a basic AWS environment for a web application. The application will be deployed across three different regions (Australia (AU), United Kingdom (UK), and United States (US)) and should have 2 separate environments for Production and Testing in each of those regions.



Tasks:



AWS Environment Setup:

Set up three different AWS regions (AU, UK, US).

For each region, create 2 separate environments: Production and Testing.

It’s up to you to design how that’s organized.

EC2 Instance Creation:

In each environment of every region, we need an EC2 instance with the following specifications:
Type: t2.micro
AMI: Windows Server 
Storage: 10GB

The EC2 instances will be hosting a website that needs to be accessible from the public Internet. No other access is needed.

S3 Bucket Creation:

Create an S3 bucket in the US region per environment.

The EC2 instances should have RW access only to this bucket. No other access should be allowed.