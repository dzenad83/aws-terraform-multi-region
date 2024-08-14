terraform {
  backend "s3" {
    bucket         = "pd-terraform-state-backend"
    key            = "ap-southeast-2/test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "pd-terraform-state"
  }
}
