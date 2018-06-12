#!/bin/bash
TERRAFORM_ACTION=$1
TF_VAR_environment=$2

echo "Performing ${TERRAFORM_ACTION}"


#Cheking required config are set

: "${TERRAFORM_ACTION:? Set terraform plan apply or destroy}"
: "${TF_VAR_environment:? Set environment dev or prod}"

echo "Performing ${TF_VAR_environment}"

if [ ${TERRAFORM_ACTION} == "apply" ]; then

cd create_stack &&
     terraform init -backend-config='key='${TF_VAR_environment}'/terraform.tfstate'
     terraform apply -auto-approve -var 'environment='${TF_VAR_environment}

elif [ ${TERRAFORM_ACTION} == "destroy" ]; then

cd create_stack &&
     terraform init -backend-config='key='${TF_VAR_environment}'/terraform.tfstate'
     terraform destroy -auto-approve -var 'environment='${TF_VAR_environment}

else
     echo "invalid option"
fi