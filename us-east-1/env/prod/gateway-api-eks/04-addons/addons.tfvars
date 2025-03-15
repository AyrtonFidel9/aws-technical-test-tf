addons = [
  {
    name              = "vpc-cni",
    version           = "v1.18.3-eksbuild.1",
    resolve_conflicts = "PRESERVE"
  },
  {
    name              = "coredns",
    version           = "v1.11.1-eksbuild.9",
    resolve_conflicts = "PRESERVE"
  },
  {
    name              = "kube-proxy",
    version           = "v1.30.0-eksbuild.3",
    resolve_conflicts = "PRESERVE"
  },
  {
    name              = "aws-ebs-csi-driver",
    version           = "v1.33.0-eksbuild.1",
    resolve_conflicts = "PRESERVE"
  },
  {
    name              = "aws-efs-csi-driver",
    version           = "v2.0.5-eksbuild.1",
    resolve_conflicts = "PRESERVE"
  },
]

created_by         = "Ayrton Fidel"
application        = "uplinq"
cost_center        = "ND"
contact            = "ayrtonfidel9@gmail.com"
maintenance_window = "ND"
deletion_date      = "ND"
environment        = "prod"