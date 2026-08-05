variable "db_name" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "vpc_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "cluster_security_group_id" {
  type = string
}