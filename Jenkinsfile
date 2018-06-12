pipeline {
    parameters {
     choice(choices: 'dev\nprod', description: 'environment?', name: 'env')
     string( name: 'TTL', defaultValue: '3', description: 'TTL for your stack in hours')
     choice(choices: 'apply\ndestroy', description: 'terraform plan?', name: 'plan')
    }

    agent {
       docker { image 'sanjanakd9/ansibleterraform:v3' }
    }

    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/sanjanakd/terraform-aws-automation']]])
                sh '''ls -ltr'''
            }
        }
        stage ('build AMI'){
            steps {
                echo "Building configuration: ${params.plan}"
                sh "cd provision_ami; packer build -var-file=vars.json apache-tomcat-ami.json"
            }
        }

        stage ('build VPC'){
             steps {
                 sh '''ls -ltr'''
                 sh "cd create_vpc; terraform init; terraform ${params.plan} -auto-approve"
             }
        }
        stage ('create/destroy stack'){
             steps {
                 sh '''ls -ltr'''
                 sh "./execute_terraform.sh ${params.plan} ${params.env} ${params.TTL}"
             }
        }

        stage('Test') {
            steps {
                echo 'Now Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Atlast, Deploying....'
            }
        }
    }
}