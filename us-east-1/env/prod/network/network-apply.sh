#!/bin/bash
# network-apply: script to apply aws resources using terraform 

echo "Applying VPC..."
sleep 5
cd 01-vpc/

terraform init -backend-config=vpc-backend.hcl
terraform plan -var-file=vpc.tfvars
terraform apply -var-file=vpc.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Subnets..."
sleep 5
cd 02-subnets/
terraform init -backend-config=subnets-backend.hcl
terraform plan -var-file=subnets.tfvars
terraform apply -var-file=subnets.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Internet Gateway..."
sleep 5
cd 03-internet-gateway
terraform init -backend-config=igw-backend.hcl
terraform plan -var-file=igw.tfvars
terraform apply -var-file=igw.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Nat Gateways..."
sleep 5
cd 04-nat-gateway/
terraform init -backend-config=nat-backend.hcl
terraform plan -var-file=nat.tfvars
terraform apply -var-file=nat.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Applying Route tables..."
sleep 5
cd 05-route-tables/
terraform init -backend-config=rtb-backend.hcl
terraform plan -var-file=rtb.tfvars
terraform apply -var-file=rtb.tfvars --auto-approve
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE APPLIED SUCCESSFULLY"