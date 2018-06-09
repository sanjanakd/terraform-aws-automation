#!/usr/bin/env python

import boto3
import os
import json

import subprocess

sqs = boto3.resource('sqs', region_name='us-east-1')

queue = sqs.get_queue_by_name(QueueName='stack-destroyer-message-queue')
consume = True

while consume:
    messages = queue.receive_messages(WaitTimeSeconds=5, MaxNumberOfMessages=5)
    for message in messages:
        print("Message received: {0}".format(message.body))
        message.delete()
        loaded_json = json.loads(message.body)
        if 'LifecycleTransition' in loaded_json:
            print ("Message EC2InstanceId: {0}".format(loaded_json['EC2InstanceId']))
            var = loaded_json['LifecycleTransition']
            if var == 'autoscaling:EC2_INSTANCE_TERMINATING':
                subprocess.call(['./destroy.sh'])
                print ("stop consuming now")
                consume = False
                break
            else:
                print("keep consuming")
                continue
        else:
            print("keep consuming")
            continue
