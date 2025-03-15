#!/bin/bash
# network-destroy: script to destroy aws resources using terraform 

echo "Destroying Endpoints..."
sleep 5
cd 06-endpoints/
terraform init -backend-config=endpoints-backend.hcl
terraform destroy --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Destroying Route tables..."
sleep 5
cd 05-route-tables/
terraform init -backend-config=rtb-backend.hcl
terraform destroy -var-file=rtb.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Nat Gateways..."
sleep 5
cd 04-nat-gateway/
terraform init -backend-config=nat-backend.hcl
terraform destroy -var-file=nat.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Internet Gateway..."
sleep 5
cd 03-internet-gateway
terraform init -backend-config=igw-backend.hcl
terraform destroy -var-file=igw.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Subnets..."
sleep 5
cd 02-subnets/
terraform init -backend-config=subnets-backend.hcl
terraform destroy -var-file=subnets.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying VPC..."
sleep 5
cd 01-vpc
terraform init -backend-config=vpc-backend.hcl
terraform destroy -var-file=vpc.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE DESTROYED SUCCESSFULLY"