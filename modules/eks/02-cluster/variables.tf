variable "eks_iam_role_arn"{
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "tags" {
  type = map
}

variable "eks_cluster_ae_role_arn" {
  type = string
}

# variable "ec2_helm_role" {
#   type = string
# }