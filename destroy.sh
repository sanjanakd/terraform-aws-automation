#! /bin/bash

#sudo su
cd create_stack && terraform init -lock=false
terraform destroy -auto-approve