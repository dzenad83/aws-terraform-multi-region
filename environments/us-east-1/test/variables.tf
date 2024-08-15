# Terraform Cloud Variables 
variable "env" {
  type = string
}
variable "region" {
  type = string
}
variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}
# ---------------------------
# EC2 variables
variable "windows_ami_ids" {
  description = "Map of Windows Server versions to AMI IDs for N.Virginia Region"
  type        = map(string)
  default     = {
    "windows2019" = "ami-016a78934c9cfa396" 
    "windows2016" = "ami-0bdf3acee9ffcb642" 
    "windows2022" = "ami-07d9456e59793a7d5" 
  }
}