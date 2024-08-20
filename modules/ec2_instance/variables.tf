variable "ami_id" {
  type = string
}
variable "private_subnet" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "user_data_file_path" {
  description = "Path to the user data script file"
  type        = string
  default     = ""  # Default empty string if no file is provided
}

variable "security_group" {
  type =list(string)
}

variable "instance_name" {
  type = string
}