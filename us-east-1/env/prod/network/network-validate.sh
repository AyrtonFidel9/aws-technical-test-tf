#!/bin/bash
# network-apply: script to validate aws resources using terraform 

echo "Validating VPC..."
sleep 5
cd 01-vpc/

terraform init -backend-config=vpc-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Subnets..."
sleep 5
cd 02-subnets/
terraform init -backend-config=subnets-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Internet Gateway..."
sleep 5
cd 03-internet-gateway
terraform init -backend-config=igw-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Nat Gateways..."
sleep 5
cd 04-nat-gateway/
terraform init -backend-config=nat-backend.hcl
terraform validate
cd ..
sleep 2

echo "Validating Route tables..."
sleep 5
cd 05-route-tables/
terraform init -backend-config=rtb-backend.hcl
terraform validate
cd ..
sleep 2


echo "Validating Endpoints..."
sleep 5
cd 06-endpoints/
terraform init -backend-config=endpoints-backend.hcl
terraform validate
cd ..
sleep 2

echo "ALL NETWORK INFRASTRUCTURE VALIDATED SUCCESSFULLY"