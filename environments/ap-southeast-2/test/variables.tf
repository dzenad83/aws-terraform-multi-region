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
  description = "Map of Windows Server versions to AMI IDs for Sydney Region"
  type        = map(string)
  default     = {
    "windows2019" = "ami-00c903abaa2feb74f" 
    "windows2016" = "ami-00a85882214748df4" 
    "windows2022" = "ami-0f8ece2612978d4cb" 
  }
}