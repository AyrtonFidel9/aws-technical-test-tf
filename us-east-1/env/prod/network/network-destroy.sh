#!/bin/bash
# network-destroy: script to destroy aws resources using terraform 

echo "Destroying Route tables..."
sleep 5
cd 05-route-tables/
terraform destroy -var-file=rtb.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Nat Gateways..."
sleep 5
cd 04-nat-gateway/
terraform destroy -var-file=nat.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Internet Gateway..."
sleep 5
cd 03-internet-gateway
terraform destroy -var-file=igw.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying Subnets..."
sleep 5
cd 02-subnets/
terraform destroy -var-file=subnets.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "Destroying VPC..."
sleep 5
cd 01-vpc
terraform destroy -var-file=vpc.tfvars --auto-approve
rm -r terraform.tfstate
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE DESTROYED SUCCESSFULLY"