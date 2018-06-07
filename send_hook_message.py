#!/usr/bin/env python

import boto3

sqs = boto3.resource('sqs', region_name='us-east-1')
# Retrieving a queue by its name
queue = sqs.get_queue_by_name(QueueName='stack-destroyer-message-queue')

data = '{"LifecycleHookName":"send-destory-message","AccountId":"014279457395","RequestId":"6eeee998-05d1-4588-9c9d-aa26dbd07c20","LifecycleTransition":"autoscaling:EC2_INSTANCE_TERMINATING","AutoScalingGroupName":"self-distruct-asg","Service":"AWS Auto Scaling","Time":"2018-06-06T18:25:39.428Z","EC2InstanceId":"i-0f5333925bbc4c6ef","LifecycleActionToken":"b51a9359-1051-415f-88d7-fe1c3f04d2cd"}'

# Create a new message
response = queue.send_message(MessageBody=data)

# The response is not a resource, but gives you a message ID and MD5
print("MessageId created: {0}".format(response.get('MessageId')))
print("MD5 created: {0}".format(response.get('MD5OfMessageBody')))

