terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "${ORGANIZATION_NAME}"

    workspaces {
      prefix = "${WORKSPACE_PREFIX}}a-"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.62.0"
    }
  }
  required_version = "~> 1.9.3"
}
provider "aws" {
  region = "ap-southeast-2"
}

# Additional provider for S3 buckets with the specific region. This one is passed into the S3_Bucket module
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}