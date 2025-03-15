#!/bin/bash
# apply: script to apply aws resources using terraform 

export AWS_PROFILE=ayrton


echo "Planning Database..."

sleep 5
terraform init -backend-config=backend.hcl
terraform plan -var-file=values.tfvars
cd ..
sleep 2


echo "DATABASE APPLIED SUCCESSFULLY"