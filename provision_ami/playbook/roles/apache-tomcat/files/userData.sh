#!/bin/bash
mkdir myApp
cd myApp
git clone https://github.com/sanjanakd/terraform-aws-automation
cd terraform-aws-automation
nohup ./read_hook_message.py >des.out

