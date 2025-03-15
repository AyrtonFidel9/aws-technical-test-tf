#!/bin/bash
# eks-apply: script to apply aws eks (k8s) resources using terraform 

echo "Planning IAM PERMISSIONS..."
sleep 5
cd 01-iam-permissions/
terraform init -backend-config=eks-iam-backend.hcl
terraform plan --var-file=eks-iam.tfvars
cd ..
sleep 2

echo "Planning Cluster Settings..."
sleep 5
cd 02-cluster/
terraform init -backend-config=cluster-backend.hcl
terraform plan --var-file=cluster.tfvars
cd ..
sleep 2

echo "Planning Node Groups..."
sleep 5
cd 03-node-group
terraform init -backend-config=ng-backend.hcl
terraform plan --var-file=node-group.tfvars
cd ..
sleep 2

echo "Planning ADD-ONS..."
sleep 5
cd 04-addons/
terraform init -backend-config=addons-backend.hcl
terraform plan --var-file=addons.tfvars
cd ..
sleep 2


echo "ALL KUBERNETES INFRASTRUCTURE PLANNED SUCCESSFULLY"