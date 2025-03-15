#!/bin/bash
# destroy: script to apply aws resources using terraform 

export AWS_PROFILE=ayrton

echo "Destroying Database..."

sleep 5
terraform init -backend-config=backend.hcl
terraform destroy -var-file=values.tfvars --auto-approve
cd ..
sleep 2


echo "DATABASE DESTROYED SUCCESSFULLY"