#!/bin/bash
TERRAFORM_ACTION=$1
TF_VAR_environment=$2
TF_STACK_TTL=$3
echo "Performing ${TERRAFORM_ACTION}"


#Cheking required config are set

: "${TERRAFORM_ACTION:? Set terraform plan apply or destroy}"
: "${TF_VAR_environment:? Set environment dev or prod}"
: "${TF_STACK_TTL:? Set TTL for your environment: 1, 2 (Time is in hours)}"

echo "Performing ${TF_VAR_environment}"

if [ ${TERRAFORM_ACTION} == "apply" ]; then

cd create_stack &&
     terraform init -backend-config='key='${TF_VAR_environment}'/terraform.tfstate'
     terraform apply -auto-approve -var 'environment='${TF_VAR_environment} -var 'stack-ttl='${TF_STACK_TTL}

elif [ ${TERRAFORM_ACTION} == "destroy" ]; then

cd create_stack &&
     terraform init -backend-config='key='${TF_VAR_environment}'/terraform.tfstate'
     terraform destroy -auto-approve -var 'environment='${TF_VAR_environment}

else
     echo "invalid option"
fi