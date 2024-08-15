# IAM Role for all EC2 instances to provide required access to the S3 Bucket
# The role is described not in the module, since there can be EC2 instances without IAM Roles, and there can be other with different permissions.

resource "aws_iam_role" "ec2_instance_role" {
  name = "ec2_s3_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

# IAM POLICY
resource "aws_iam_policy" "s3_access_policy" {
  name = "S3AccessPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::pda-s3-bucket",
          "arn:aws:s3:::pda-s3-bucket/*"
        ]
      }
    ]
  })
}



module "s3-bucket" {
  source  = "../../../modules/s3_bucket"

  bucket_name = "pda-s3-bucket"
  ec2_instance_role_arn = aws_iam_role.ec2_instance_role.arn
}
