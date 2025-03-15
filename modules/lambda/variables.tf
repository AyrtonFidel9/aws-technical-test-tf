variable "tags" {
  type = map
}

variable "subnets_id" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "handler" {
  type = string
  default = "index.test"
}

variable "runtime" {
  type = string
  default = "nodejs18.x"
}

variable "filename" {
  
}

variable "storage" {
  type = string
  default = 512
}

variable "ram" {
  type = number
  default = 128
}

variable "s3_bucket_arn" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}

variable "cidr_blocks" {
  type = list(string)
}