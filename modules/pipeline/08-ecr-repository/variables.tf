variable "tags" {
  description = "Tags to be associated with the ECR repository"
  type        = map
}

variable "repositories" {
  type = list(string)
}