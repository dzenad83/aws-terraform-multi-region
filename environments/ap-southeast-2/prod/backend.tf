# terraform {
#   backend "s3" {
#     bucket         = "pd-terraform-state-backend"
#     key            = "ap-southeast-2/prod/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "pd-terraform-state"
#   }
# }

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "PowerDiaryAssignment"

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
}
