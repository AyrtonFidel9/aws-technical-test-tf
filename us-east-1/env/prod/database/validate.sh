#!/bin/bash
# validate: script to apply aws resources using terraform 

export AWS_PROFILE=ayrton


echo "Validating Database..."

sleep 5
terraform init -backend-config=backend.hcl
terraform validate
cd ..
sleep 2


echo "DATABASE VALITED SUCCESSFULLY"