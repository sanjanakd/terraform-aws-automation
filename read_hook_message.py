#!/usr/bin/env python

import boto3
import os
import json

import subprocess

sqs = boto3.resource('sqs',region_name='us-east-1')

queue = sqs.get_queue_by_name(QueueName='stack-destroyer-message-queue')

while 1:
    messages = queue.receive_messages(WaitTimeSeconds=5,MaxNumberOfMessages=1)
    for message in messages:
        print("Message received: {0}".format(message.body))
        message.delete()
        loaded_json = json.loads(message.body)
        print ("Message EC2InstanceId: {0}".format(loaded_json['EC2InstanceId']))
        subprocess.call(['./destroy.sh'])
        break
    break
