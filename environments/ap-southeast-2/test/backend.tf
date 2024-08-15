terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Power-Diary"

    workspaces {
      prefix = "pda-"
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