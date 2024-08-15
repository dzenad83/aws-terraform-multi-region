resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}
  # Server-Side Encryption with Amazon S3-Managed Keys (SSE-S3)
  resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
  }
}

# Block public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # Allow read-write access to EC2 instances with a specific IAM role
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.ec2_instance_role.arn
        }
        Action    = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource  = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}


