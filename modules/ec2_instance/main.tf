
# EC2 Instance

resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.instance_name}-s3-access-role"

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



resource "aws_iam_instance_profile" "webserver_instance_profile" {
  name = "${var.instance_name}-profile"
  role = aws_iam_role.ec2_instance_role.name
}


resource "aws_instance" "webserver" {
  ami                         = var.ami_id  
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet
  vpc_security_group_ids      = [aws_security_group.webserver.id]
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.webserver_instance_profile.name    
  user_data = length(var.user_data_file_path) > 0 ? file(var.user_data_file_path) : null


  root_block_device {
    volume_size = 10 
    encrypted = true
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "webserver" {

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.security_group # Application Load Balancer Security Group Required. This is a list of strings, multiple sec. groups can be provided
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}