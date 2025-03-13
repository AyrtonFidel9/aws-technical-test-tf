variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "subnets_type" {
  description = "subnet type (public | private | isolated)"
  type = string
}

variable "azs" {
  description = "availability zones to use in the vpc"
  type = list(string)
}

variable "subnets" {
  description = "all cidr ranges needed to create the subnets"
  type = list(string)
}

variable "additional_name" {
  description = "additional name to customize more the subnet final name"
  type = string
  default = "no-name"
}

variable "tags" {
  type = map
}