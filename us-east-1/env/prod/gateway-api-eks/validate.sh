#!/bin/bash
# eks-apply: script to apply aws eks (k8s) resources using terraform 

echo "Validating IAM PERMISSIONS..."
sleep 5
cd 01-iam-permissions/
terraform init -backend-config=eks-iam-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Cluster Settings..."
sleep 5
cd 02-cluster/
terraform init -backend-config=cluster-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Node Groups..."
sleep 5
cd 03-node-group
terraform init -backend-config=ng-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating ADD-ONS..."
sleep 5
cd 04-addons/
terraform init -backend-config=addons-backend.hcl
terraform validate
cd ..
sleep 2


echo "ALL KUBERNETES INFRASTRUCTURE VALIDATED SUCCESSFULLY"