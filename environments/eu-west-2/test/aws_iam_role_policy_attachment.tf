# IAM POLICY for S3 Bucket
resource "aws_iam_policy" "s3_access_policy" {
  name = "${var.region}-${var.env}"

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
          "${module.s3_bucket.bucket_arn}",
          "${module.s3_bucket.bucket_arn}/*"
        ]
      }
    ]
  })

  depends_on = [ module.ec2_instance, module.s3_bucket ]
}

# Attaching the IAM Policy to the IAM Role on the EC2 instance
resource "aws_iam_policy_attachment" "iam-attachment" {
  name       = "ec2-role-polcy-attachment"
  roles      = [module.ec2_instance.instance_role.name]
  policy_arn = aws_iam_policy.s3_access_policy.arn

  depends_on = [ aws_iam_policy.s3_access_policy ]
}