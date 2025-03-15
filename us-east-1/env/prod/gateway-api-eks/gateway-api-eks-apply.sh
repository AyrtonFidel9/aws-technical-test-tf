#!/bin/bash
# eks-apply: script to apply aws eks (k8s) resources using terraform 

echo "Applying IAM PERMISSIONS..."
sleep 5
cd 01-iam-permissions/
terraform init -backend-config=eks-iam-backend.hcl
terraform plan --var-file=eks-iam.tfvars
terraform apply --var-file=eks-iam.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Cluster Settings..."
sleep 5
cd 02-cluster/
terraform init -backend-config=cluster-backend.hcl
terraform plan --var-file=cluster.tfvars
terraform apply --var-file=cluster.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Node Groups..."
sleep 5
cd 03-node-group
terraform init -backend-config=ng-backend.hcl
terraform plan --var-file=node-group.tfvars
terraform apply --var-file=node-group.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying ADD-ONS..."
sleep 5
cd 04-addons/
terraform init -backend-config=addons-backend.hcl
terraform plan --var-file=addons.tfvars
terraform apply --var-file=addons.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2


echo "ALL KUBERNETES INFRASTRUCTURE APPLIED SUCCESSFULLY"