#!/bin/bash
# eks-destroy: script to destroy aws eks (k8s) resources using terraform 

echo "Destroying ADD-ONS..."
sleep 5
cd 04-addons/
terraform destroy --var-file=addons.tfvars --auto-approve
cd ..
sleep 2

echo "Destroying Node Groups..."
sleep 5
cd 03-node-group/
terraform destroy --var-file=node-group.tfvars --auto-approve
cd ..
sleep 2

echo "Destroying Cluster Settings..."
sleep 5
cd 02-cluster/
terraform destroy --var-file=cluster.tfvars --auto-approve
cd ..
sleep 2

echo "Destroying IAM PERMISSIONS..."
sleep 5
cd 01-iam-permissions/
terraform destroy --var-file=eks-iam.tfvars --auto-approve
cd ..
sleep 2

echo "ALL KUBERNETS INFRASTRUCTURE DESTROYED SUCCESSFULLY"