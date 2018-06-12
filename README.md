#terraform-aws-automation

Overview :
-----------

This automation is supported for ubuntu only.

This project is divided into 3 parts -
1. Provision an AMI using packer and Ansible which has apache tomcat, java8, terraform, python and one sample flask application.
2. Create VPC/IAM with subnet using terraform.
3. and create stack using terraform which creates Security groups, Autoscaling groups with 2 EC2 instance, ELB and route53.


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

##Integration with Ansible :
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

	b. If the plan looks good, create the vpc/IAM:

			$ terraform apply

	c. To destroy the vpc/IAM, run following command to see the destroy plan is managing and will destroy.

			$ terraform plan -destroy

	d. If the plan looks good destroy vpc can be done using below command:

			$ terraform destroy


3. Create stack using Terraform

	create_stack  directory has terraform script to create -
	1. Security Groups
	2. Launch Configuration & Autoscaling Group
	3. Launch configuration and self distructive Autoscaling group
	4. Elastic Load balancer
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

    The stack we created earlier will be destroyed automatically after the ttl expiration. We provided ttl while creating the stack as 3rd argument.

    Here is how auto destruction works:


To auto destroy the stack, I created couple of following extra resources along with the stack.

1. Auto scaling group with min and max size to 1. (Destroyer ASG)
2. An EC2 instance with SQS poller in user data script.
3. Life cycle hook on instance termination.
4. SQS queue to recieve ASG lifecyle notificaion.
5. A scheduler using TTL to scale in ASG to desired size 0.


    When auto scaling group scales in because of the scheuler we created, it will terminate the instance to achive the desired size. This will trigger the lifecycle hook to put ec2 instance in waiting state. The Lifecycle hook is configured to send notifcation to SQS regarding termination. As instance terminates, lifecycle hook will send an notification to SQS and puts the EC2 into waiting state.

    As said in earlier, the ec2 has a SQS poller watching the SQS quque, poller script reads the notification from SQS and triggers the destroy.sh script. As ec2 is in waiting state, destroy.sh script will destroy the stack. The only thing that should be left behind is the Destroyer auto scaling group.
