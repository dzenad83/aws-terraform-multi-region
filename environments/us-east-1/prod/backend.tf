terraform {
  backend "s3" {
    bucket         = "pd-terraform-state-backend"
    key            = "us-east-1/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pd-terraform-state"
  }
}
