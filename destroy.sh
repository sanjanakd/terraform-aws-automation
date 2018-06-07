#! /bin/bash

cd create_stack
terraform init  -backend=true -backend-config="bucket=myansibleprojectbucket"  -backend-config="key=terraform.tfstate" -backend-config="region=us-east-1" -backend-config="encrypt=true"

terraform destroy -auto-approve