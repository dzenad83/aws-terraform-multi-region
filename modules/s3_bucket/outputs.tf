# Output the S3 bucket name
output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

# Output the S3 bucket ARN
output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
