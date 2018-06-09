#! /bin/bash

sudo su
apt install python -y
apt install python-pip -y
pip install botocore
pip install boto3

cd
mkdir myApp
cd myApp
git clone https://github.com/sanjanakd/terraform-aws-automation
cd terraform-aws-automation
chmod +x destroy.sh
nohup ./read_hook_message.py
