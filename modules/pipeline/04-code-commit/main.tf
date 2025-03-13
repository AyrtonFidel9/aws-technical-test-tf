resource "aws_codecommit_repository" "tf_infrastructure_repository" {
  repository_name = "${var.tags.Application}-${var.tags.Environment}-repository"
  default_branch  = var.branch_default_name
  description     = var.tags.Description
  tags            = tomap(var.tags)
}