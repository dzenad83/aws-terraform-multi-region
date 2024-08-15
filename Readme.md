# Power Diary Assignment

### Infrastructure Diagram

<img src="images/pda-infrastructure.jpg" alt="Alt text" height="500">

### Understanding Repository Structure

Since the assignment is about creating two environments in three different regions (total 6), I assumed that I should demonstrate how this small project could function within a larger ecosystem. Therefore, I laid out a complete folder structure to support this. For this approach, Terraform Cloud and Terragrunt would be most suitable. I chose Terraform Cloud because it provides a complete UI experience. Even though Terragrunt has it's own benefits and advantages.

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

Every environment will have it's own state! This is because we want to be able to do two things.
The folder `/modules/` contains custom made modules that can be reused in all environments. For example, all environments could have the same EC2 Instance Configuration, therefore it can be custom defined once as a `/modules/ec2` and reused in all environments.

### Logging in to Terraform Cloud

In order to be able to run `terraform init` and `terraform plan` locally you need to login and connect to Terraform Cloud via CLI.
To accomplish that, in your command prompt run `terraform login` and follow the procedure: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login

### Initializing Terraform

Pre-condition for this project to run is to use have terraform version `1.9.3` or later installed on your system.
To check your version simply type `terraform -version`
If you have an older version, please follow instructions on Terraform official for upgrade.
https://developer.hashicorp.com/terraform/install

It is important to notice that in this repository we have 6 environments and each has a state. This means that we keep 6 states, one for each environment.

### Access and Authorization

To be able to initilize terraform and make changes in the AWS region "ap-southeast-2" specifically on the testing environment, change directory into `/environments/ap-southeast-2/test` and execute `terraform init`
Note, for this terraform workspace to initilize on your system, you do not require AWS credentials, your access should be authorized by your Github credentials in Terraform Cloud.
Therefore it is required that your Github Account is associated with the Terraform Workspace. Terraform Cloud will use a service account user to authenticate to AWS directly.

### Terraform Plan and Apply

Once you have been logged in and authorized, you can perform terraform plans from local console, but `terraform apply` is not allowed. It is only possible to be executed through the web console in the Terraform Cloud UI: https://app.terraform.io/app/Power-Diary/workspaces

### How to make changes

To make a change create a feature branch on Github from the test branch. Developers are allowed to make feature branches and once ready, you can create a Merge Request to the test branch. All changes in this phase should be done in the `/environments/ap-southeast-2/test`folder.
Once that has been created, every push to the feature branch will trigger a terraform plan that can be observed in the Merge request itself, as well as in the Terraform Cloud Console.

Since the testing environment is completly decoupled from the production environment, we would have to apply the changes in the production folder by adding the changes manually in the `/environments/ap-southeast-2/prod` folder.

There are different folders to keep the state, changes, and terraform maintenance clean. And to be able to deploy different infrastructures accross environments since there might be infrastructure in one environment, that is not required in another. For example we need EC2 instances with more CPU in one region, or we need want to start testing a new API Endpoint in one region, while that is not happening in another. Etc.
