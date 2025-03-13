resource "aws_eks_addon" "tf_eks_addons" {
  count = length(var.addons)
  cluster_name                = var.cluster_name
  addon_name                  = var.addons[count.index].name#"vpc-cni"
  addon_version               = var.addons[count.index].version 
  resolve_conflicts_on_update = var.addons[count.index].resolve_conflicts
  service_account_role_arn    = var.addons[count.index].name == "vpc-cni" ? (
    aws_iam_role.tf_vpc_cni_role.arn
  ) : (
    var.addons[count.index].name == "coredns" ? (
      ""
    ) : (
      var.addons[count.index].name == "kube-proxy" ? (
        ""
      ) : (
        var.addons[count.index].name == "aws-ebs-csi-driver" ? (
          aws_iam_role.tf_ebs_csi_driver_role.arn
        ) : (
          var.addons[count.index].name == "aws-efs-csi-driver" ? (
            aws_iam_role.tf_efs_csi_driver_role.arn
          ) : ""
        ) 
      )
    )
  )
}
