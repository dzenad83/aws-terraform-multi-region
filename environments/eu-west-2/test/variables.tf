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
  description = "Map of Windows Server versions to AMI IDs for London Region"
  type        = map(string)
  default     = {
    "windows2019" = "ami-076d13fc3c989e8e4" 
    "windows2016" = "ami-0c8f3e8cfd84958e5" 
    "windows2022" = "ami-04d55999748c1974a" 
  }
}