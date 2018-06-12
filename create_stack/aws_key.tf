#ssh-keygen -t rsa
#openssl rsa -in ~/.ssh/id_rsa -outform pem > id_rsa.pem

resource "aws_key_pair" "developer" {
  key_name = "developer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIRxA3dJTqFxPCYR/oFYq8ZqweTpH1KOvON0mwBNrina2qWLZ9zI87N6H/l0FULYmsPMd6veufPzIhaxir8QAj77ProA8gGKPYuppAddgnrVRUovpHU3m5IV8dRhFTfPUM8WTBT88EF2xV4SDiKRCAgBRppnS2zZTqmQ/QRpx4d3eIXpJ77cCzvgipgkW9gRLMKCne9obUmS7z0Ijl2lxz/fivrloRQV7geh+zQUBre+pAvafW9R73CpNn/Rpyou00o5BytMChib1pVoqm1IIXZ8ioK8dRXYXNYQi6+ojoj59SMNIlhKV9ItCsirbeho+pxxGQkUV//pS1SYzXdwmz sanjanakadam@Sanjanas-MBP.fios-router.home"
}


resource "aws_key_pair" "destroyerkey" {
  key_name = "destroyer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIRxA3dJTqFxPCYR/oFYq8ZqweTpH1KOvON0mwBNrina2qWLZ9zI87N6H/l0FULYmsPMd6veufPzIhaxir8QAj77ProA8gGKPYuppAddgnrVRUovpHU3m5IV8dRhFTfPUM8WTBT88EF2xV4SDiKRCAgBRppnS2zZTqmQ/QRpx4d3eIXpJ77cCzvgipgkW9gRLMKCne9obUmS7z0Ijl2lxz/fivrloRQV7geh+zQUBre+pAvafW9R73CpNn/Rpyou00o5BytMChib1pVoqm1IIXZ8ioK8dRXYXNYQi6+ojoj59SMNIlhKV9ItCsirbeho+pxxGQkUV//pS1SYzXdwmz sanjanakadam@Sanjanas-MBP.fios-router.home"
}