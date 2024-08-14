# S3 Bucket in production environment will be shared with all other environments
module "s3-bucket" {
  source  = "../../../modules/s3_bucket"

  bucket_name = "pda-s3-bucket"
}
