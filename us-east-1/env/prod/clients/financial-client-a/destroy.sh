#!/bin/bash

export AWS_PROFILE=ayrton


echo "Destroying Inference Domain..."
sleep 5
cd Inference-Domain/
terraform init -backend-config=backend.hcl
terraform destroy --var-file=values.tfvars --auto-approve
cd ..
sleep 2


echo "Destroying PII Sanitizer..."
sleep 5
cd PII-Sanitizer/
terraform init -backend-config=backend.hcl
terraform destroy --var-file=values.tfvars --auto-approve
cd ..
sleep 2