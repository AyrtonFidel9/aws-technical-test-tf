# vpc-cni-service-role
data "aws_iam_policy_document" "tf_vpc_cni_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.openid_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [var.openid_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "tf_vpc_cni_role" {
  assume_role_policy = data.aws_iam_policy_document.tf_vpc_cni_assume_role_policy.json
  name               = "${var.tags.Application}-${var.tags.Environment}-vpc-cni-role"
}

resource "aws_iam_role_policy_attachment" "tf_vpc_cni_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.tf_vpc_cni_role.name
}

# ebs-csi-controller-role-service
data "aws_iam_policy_document" "tf_ebs_csi_driver_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.openid_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    principals {
      identifiers = [var.openid_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "tf_ebs_csi_driver_role" {
  assume_role_policy = data.aws_iam_policy_document.tf_ebs_csi_driver_assume_role_policy.json
  name               = "${var.tags.Application}-${var.tags.Environment}-ebs-csi-driver-role"
}

resource "aws_iam_role_policy_attachment" "tf_ebs_csi_driver_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.tf_ebs_csi_driver_role.name
}

# efs-csi-controller-role-service
data "aws_iam_policy_document" "tf_efs_csi_driver_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.openid_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
    }

    principals {
      identifiers = [var.openid_arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "tf_efs_csi_driver_efs_permissions" {
  statement {
    actions = [
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones"
    ]
    effect  = "Allow"
    resources = [ "*" ]
  }
}

resource "aws_iam_policy" "tf_efs_csi_driver_role_policy" {
  policy = data.aws_iam_policy_document.tf_efs_csi_driver_efs_permissions.json
  name = "${var.tags.Application}-${var.tags.Environment}-policy-permission-efs"
}

data "aws_iam_policy_document" "tf_efs_csi_driver_efs_access_point_permissions" {
  statement {
    actions = [
      "elasticfilesystem:TagResource"
    ]
    effect  = "Allow"
    resources = [ "*" ]
    condition {
      test = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values = [ "true" ]
    }
  }
}

resource "aws_iam_policy" "tf_efs_csi_driver_role_tag_policy" {
  policy = data.aws_iam_policy_document.tf_efs_csi_driver_efs_access_point_permissions.json
  name = "${var.tags.Application}-${var.tags.Environment}-policy-permission-tag-efs"
}

data "aws_iam_policy_document" "tf_efs_csi_driver_efs_access_point_delete_permissions" {
  statement {
    actions = [
      "elasticfilesystem:DeleteAccessPoint"
    ]
    effect  = "Allow"
    resources = [ "*" ]
    condition {
      test = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values = [ "true" ]
    }
  }
}

resource "aws_iam_policy" "tf_efs_csi_driver_role_delete_ap_policy" {
  policy = data.aws_iam_policy_document.tf_efs_csi_driver_efs_access_point_delete_permissions.json
  name = "${var.tags.Application}-${var.tags.Environment}-policy-permission-ap-delete-efs"
}


resource "aws_iam_role" "tf_efs_csi_driver_role" {
  assume_role_policy = data.aws_iam_policy_document.tf_efs_csi_driver_assume_role_policy.json
  name               = "${var.tags.Application}-${var.tags.Environment}-efs-csi-driver-role"
}

resource "aws_iam_role_policy_attachment" "tf_efs_csi_driver_role_policy_attachment" {
  policy_arn = aws_iam_policy.tf_efs_csi_driver_role_policy.arn
  role       = aws_iam_role.tf_efs_csi_driver_role.name
}

resource "aws_iam_role_policy_attachment" "tf_efs_csi_driver_role_policy_attachment_2" {
  policy_arn = aws_iam_policy.tf_efs_csi_driver_role_tag_policy.arn
  role       = aws_iam_role.tf_efs_csi_driver_role.name
}

resource "aws_iam_role_policy_attachment" "tf_efs_csi_driver_role_policy_attachment_3" {
  policy_arn = aws_iam_policy.tf_efs_csi_driver_role_delete_ap_policy.arn
  role       = aws_iam_role.tf_efs_csi_driver_role.name
}