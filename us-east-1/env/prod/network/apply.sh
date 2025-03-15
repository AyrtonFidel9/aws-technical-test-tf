#!/bin/bash
# network-apply: script to apply aws resources using terraform 

echo "Applying VPC..."
sleep 5
cd 01-vpc/
export AWS_PROFILE=ayrton
terraform init -backend-config=vpc-backend.hcl
terraform apply -var-file=vpc.tfvars --auto-approve
cd ..
sleep 2

echo "Applying Subnets..."
sleep 5
cd 02-subnets/
export AWS_PROFILE=ayrton
terraform init -backend-config=subnets-backend.hcl
terraform apply -var-file=subnets.tfvars --auto-approve
cd ..
sleep 2

echo "Applying Internet Gateway..."
sleep 5
cd 03-internet-gateway
export AWS_PROFILE=ayrton
terraform init -backend-config=igw-backend.hcl
terraform apply -var-file=igw.tfvars --auto-approve
cd ..
sleep 2

echo "Applying Nat Gateways..."
sleep 5
cd 04-nat-gateway/
export AWS_PROFILE=ayrton
terraform init -backend-config=nat-backend.hcl
terraform apply -var-file=nat.tfvars --auto-approve
cd ..
sleep 2

echo "Applying Route tables..."
sleep 5
cd 05-route-tables/
export AWS_PROFILE=ayrton
terraform init -backend-config=rtb-backend.hcl
terraform apply -var-file=rtb.tfvars --auto-approve
cd ..
sleep 2


echo "Applying Endpoints..."
sleep 5
cd 06-endpoints/
export AWS_PROFILE=ayrton
terraform init -backend-config=endpoints-backend.hcl
terraform apply --auto-approve
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE APPLIED SUCCESSFULLY"