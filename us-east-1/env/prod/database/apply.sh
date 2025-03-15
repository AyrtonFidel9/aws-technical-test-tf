#!/bin/bash
# apply: script to apply aws resources using terraform 

export AWS_PROFILE=ayrton


echo "Applying Database..."

sleep 5
terraform init -backend-config=backend.hcl
terraform apply -var-file=values.tfvars --auto-approve
cd ..
sleep 2


echo "DATABASE APPLIED SUCCESSFULLY"