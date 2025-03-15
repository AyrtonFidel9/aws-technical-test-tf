#!/bin/bash
# network-apply: script to apply aws resources using terraform 

echo "Planning' VPC..."
sleep 5
cd 01-vpc/

terraform init -backend-config=vpc-backend.hcl
terraform plan -var-file=vpc.tfvars
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Planning Subnets..."
sleep 5
cd 02-subnets/
terraform init -backend-config=subnets-backend.hcl
terraform plan -var-file=subnets.tfvars
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Planning Internet Gateway..."
sleep 5
cd 03-internet-gateway
terraform init -backend-config=igw-backend.hcl
terraform plan -var-file=igw.tfvars
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Planning Nat Gateways..."
sleep 5
cd 04-nat-gateway/
terraform init -backend-config=nat-backend.hcl
terraform plan -var-file=nat.tfvars
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "Planning' Route tables..."
sleep 5
cd 05-route-tables/
terraform init -backend-config=rtb-backend.hcl
terraform plan -var-file=rtb.tfvars
terraform state pull > terraform.tfstate
cd ..
sleep 2


echo "Planning' Endpoints..."
sleep 5
cd 06-endpoints/
terraform init -backend-config=endpoints-backend.hcl
terraform plan
terraform state pull > terraform.tfstate
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE PLANNED SUCCESSFULLY"