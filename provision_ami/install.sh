#!/bin/bash

sudo apt install python -y
sudo apt-get install software-properties-common
sudo apt-add-repository universe
sudo apt-get update
sudo apt-get install python-pip -y
sudo pip install botocore && sudo pip install boto3 && sudo pip install flask
