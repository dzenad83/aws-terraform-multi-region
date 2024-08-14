Power Diary Technical Assignment for DevOps Engineer Interview 



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



Notes:

Including some documentation, such as a Readme file, detailing how to run the code and explaining any design decision is encouraged.

While the code needs to be deployable, you are not required to deploy anything to AWS. Important: Please do not incur any AWS expenses as Power Diary will not be responsible or compensate those.

Following best practices in terms of architecture and security is critical for us. Ensure to follow them throughout the challenge.

Ensure the repository is well-organized and follows best practices for directory structure and naming conventions.



Submission:

Push your code and documentation to a new GitHub repository (or similar). Ensure that the repository is public and can be accessed for evaluation.

Please submit your solution to people@powerdiary.com when you're done.