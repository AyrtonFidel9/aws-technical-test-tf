#!/bin/bash

echo "Validating Inference Domain..."
sleep 5
cd Inference-Domain/
terraform init -backend-config=backend.hcl
terraform validate
cd ..
sleep 2


echo "Validating PII Sanitizer..."
sleep 5
cd PII-Sanitizer/
terraform init -backend-config=backend.hcl
terraform validate
cd ..
sleep 2