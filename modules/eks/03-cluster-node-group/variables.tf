variable "cluster_name" {
  type = string
}

variable "node_group_iam_role_arn" {
  type = string
}

variable "node_groups" {
}

variable "subnet_ids" {
  type = list(string)
}

/*
variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_unavailable" {
  type = number
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}
*/
variable "tags" {
  type = map
}