#! /bin/bash

cd create_stack &&
     terraform init -backend-config='key=dev/terraform.tfstate'
     terraform destroy -var 'environment=dev'

