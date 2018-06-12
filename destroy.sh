#! /bin/bash

cd create_stack &&
     terraform init -backend-config='key=dev/terraform.tfstate'
     terraform destroy -auto-approve -var 'environment=dev'

