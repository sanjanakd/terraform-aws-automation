Terraform-AWS-Automation
--------------------------

Overview :
-----------

This automation is supported for ubuntu only.

This project is divided into 3 parts -
1. Provision an AMI using packer and Ansible which has apache tomcat, java8, terraform, python and one sample flask application.
2. Create VPC/IAM with subnet using terraform.
3. and create stack using terraform which creates Security groups, Auto scaling groups with 2 EC2 instance, ELB and route53.


Prerequisites :
---------------

Terraform, Ansible and Python


Instructions :
---------------

1. Provisioning AMI using Packer and Anisble :

    Baking AMI consist of Packer and Ansible which are integrated together.

Running Packer:
Go to the directory : provision_ami and run -

```	
- packer build -var-file=vars.json apache-tomcat-ami.json
```

Integration with Ansible :
  To Integrate packer with Ansible:
  
  1. The Ansible code is copied ino the playbook directory inside provision_ami directory
  2. The Ansible provisioner is then used to integrate Ansible with packer.
  3. Once a system is created with AMI, apache tomcat, java 8, python2 and its packages and terraform will be up and running.


2. Creating VPC/IAM Roles :

    Create_vpc directory contains terraform script to create VPC with 2 public subnets and IAM roles.


Execute :
----------

   a. Go to create_vpc folder and run the following command to initialize backend
			
			$ terraform init

   b. Run following command to see what terraform plans to do, without actually creating anything:
			
			$ terraform plan

   c. If the plan looks good, create the vpc/IAM:
			
			$ terraform apply

   d. To destroy the vpc/IAM, run following command to see the destroy plan is managing and will destroy.
			
			$ terraform plan -destroy

   e. If the plan looks good destroy vpc can be done using below command:
			
			$ terraform destroy


3. Create stack using Terraform

	create_stack  directory has terraform script to create -
	1. Security Groups
	2. Launch Configuration & Auto scaling Group
	3. Launch configuration and self destructive Auto scaling group
	4. Elastic Load Balancer
	5. Route53

Running Terraform:
------------------

To create stack in dev or prod environment, you can directly execute shell script from project root folder - ./execute_terraform.sh apply env ttl

		$ ./execute_terraform.sh apply  dev  2

  above command will create stack that will be destroyed after 2 hours


  To destroy stack in dev/prod environment, execute following command -

		$ ./execute_terraform.sh destroy dev


Auto Destruction:
------------------

The stack we created earlier will be destroyed automatically after the ttl expiration, we provided ttl while creating the     stack as 3rd argument.


To auto destroy the stack, I created couple of following extra resources along with the stack.

1. Auto scaling group with min and max size to 1. (Destroyer ASG)
2. An EC2 instance with SQS poller in user data script.
3. Life cycle hook on instance termination.
4. SQS queue to receive ASG lifecycle notification.
5. A scheduler using TTL to scale in ASG to desired size 0.

Here is how auto destruction works:

  When auto scaling group scales in because of the scheduler we created, it will terminate the instance to archive the desired size. This will trigger the lifecycle hook to put ec2 instance in waiting state. The Lifecycle hook is configured to send notifcation to SQS regarding termination. As instance terminates, lifecycle hook will send an notification to SQS and puts the EC2 into waiting state.

As I said earlier, the ec2 has a SQS poller watching the SQS Queue, poller script reads the notification from SQS and triggers the destroy.sh script. As ec2 is in waiting state, destroy.sh script will destroy the stack. The only thing that should be left behind is the Destroyer auto scaling group.




Test: 
--------
To check if stack is up, capture the elb DNS and replace it in following url. You should see "Hello World".
(You might see cert ERROR as I used self signed certificates but click on "Advanced and proceed to" to see the output)

https://elbDNS:443
