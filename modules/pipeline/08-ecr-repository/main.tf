resource "aws_ecr_repository" "tf_ecr_repository" {
  count = length(var.repositories)
  name = "${var.repositories[count.index]}-${var.tags.Application}-${var.tags.Environment}-ecr-repository"
  tags = tomap(var.tags)
}