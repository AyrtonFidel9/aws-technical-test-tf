variable "tags" {
  type = map
}


variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
}

variable "billing_mode" {
  default = "PROVISIONED"
}

variable "read_capacity" {
  default = 20
}

variable "write_capacity" {
  default = 20
}

variable "hash_key" {
  
}

variable "range_key" {
  
}