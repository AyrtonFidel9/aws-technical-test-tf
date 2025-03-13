variable "azs" {
  description = "availability zones to deploy the nat gateway"
  type = list(string)
}

variable "tags" {
  description = "nat gateway tags"
  type = map
}

variable "subnet_allocation_ids" {
  type = list(string)
}