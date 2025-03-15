#!/bin/bash

export AWS_PROFILE=ayrton

echo "Planning Inference Domain..."
sleep 5
cd Inference-Domain/
terraform init -backend-config=backend.hcl
terraform plan --var-file=values.tfvars
cd ..
sleep 2


echo "Planning PII Sanitizer..."
sleep 5
cd PII-Sanitizer/
terraform init -backend-config=backend.hcl
terraform plan --var-file=values.tfvars
cd ..
sleep 2