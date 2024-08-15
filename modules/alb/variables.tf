variable "name" {
  type = string
  default = "alb"
}

variable "security_group_id" {
  type = string
}
variable "public_subnets_ids" {
  type = list(string)
}

variable "instance_id" {
  type = string
}
variable "vpc_id" {
    type = string
    default = ""
}
variable "certificate_arn" {
  type = string
}