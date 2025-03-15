#!/bin/bash


echo "Applying Inference Domain..."
sleep 5
cd Inference-Domain/
terraform init -backend-config=backend.hcl
terraform apply --var-file=values.tfvars --auto-approve
cd ..
sleep 2


echo "Applying PII Sanitizer..."
sleep 5
cd PII-Sanitizer/
terraform init -backend-config=backend.hcl
terraform apply --var-file=values.tfvars --auto-approve
cd ..
sleep 2