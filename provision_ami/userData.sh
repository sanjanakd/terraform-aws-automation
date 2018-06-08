#! /bin/bash

apt install python
apt install python-pip -y
pip install botocore -y
pip install boto -y

cd
mkdir myApp
cd myApp
git clone https://github.com/sanjanakd/terraform-aws-automation
cd terraform-aws-automation
chmod +x destroy.sh
nohup ./read_hook_message.py
