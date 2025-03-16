variable "tags" {
  type = map
}

variable "db_type" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "engine" {
  type = string
}

variable "parameter_group_family" {
  type = string
}

variable "storage" {
  
}

variable "username" {
  type = string
}

variable "subnets_id" {
  type = list(string)
}

variable "ingress_subnets_cidr" {
  type = list(string)
}

variable "port" {
  
}

variable "vpc_id" {
  description = "Wordpress Public Subnets"
}