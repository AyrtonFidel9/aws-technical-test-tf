resource "aws_eks_node_group" "eks_node_group" {
  count = length(var.node_groups)
  cluster_name      = var.cluster_name
  node_group_name   = "${var.tags.Environment}-${var.tags.Application}-node-group-${count.index+1}"
  node_role_arn     = var.node_group_iam_role_arn
  subnet_ids        = var.subnet_ids
  instance_types    = var.node_groups[count.index].instance_types
  capacity_type     = var.node_groups[count.index].capacity_type 
  //ami_type          = var.node_groups[count.index].ami_type

  scaling_config {
    desired_size  = var.node_groups[count.index].desired_size
    max_size      = var.node_groups[count.index].max_size
    min_size      = var.node_groups[count.index].min_size 
  }

  update_config {
    max_unavailable = var.node_groups[count.index].max_unavailable
  }

  tags = tomap(var.tags)
}