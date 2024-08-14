terraform {
  backend "s3" {
    bucket         = "pd-terraform-state-backend"
    key            = "eu-west-2/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pd-terraform-state"
  }
}
