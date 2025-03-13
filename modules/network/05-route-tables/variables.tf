variable "subnets" {
}

variable "type" {
  type = string
  description = "private | public | isolated"
}

variable "additional_name" {
  description = "additional name to customize more the route table final name"
  type = string
  default = "no-name"
}

variable "vpc_id" {
  type = string
}

variable "internet_gateway_id" {
  type = string
  default = "no-id"
}

variable "nat_gateways_id" {
  type = list(string)
  default = []
}

variable "tags" {
  type = map
}

variable "cidr_igw" {
  default = "0.0.0.0/0"
}

variable "cidr_nat" {
  default = "0.0.0.0/0"
}