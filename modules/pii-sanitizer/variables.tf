variable "tags" {
  type = map
}

variable "instance_subnet_id" {
  type = string
}

variable "vpc_id" {
  description = "Wordpress Public Subnets"
}

variable "public_subnets_id" {
  type = list(string)
}

variable "ebs_optimized" {
  type = bool
  default = true
}

variable "public_ip_address" {
  type = bool
  default = true
}

variable "ami_instance_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "volume_size" {
  type = number
  default = 20
}


variable "volume_type" {
  type = string
  default = "gp3"
}

variable "ebs_encrypted" {
  type = bool
  default = true
}


variable "device_name" {
  type = string
  default = "/dev/xvda"
}


variable "user_data" {
  
}