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
variable "webserver_role" {
  description = "Path to the user data script file"
  type        = string
  default     = ""  # Default empty string if no role is provided
}

variable "alb_security_group" {
  type =list(string)
  default = [ "0.0.0.0/0" ]
}