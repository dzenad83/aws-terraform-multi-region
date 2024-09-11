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
  region = "us-east-1"
}