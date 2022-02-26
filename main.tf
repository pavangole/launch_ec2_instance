provider "aws" {
    region = var.region
}

resource "tls_private_key" "pk" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "promkey" {
    key_name = var.ssh_key_name
    public_key = tls_private_key.pk.public_key_openssh

    provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./promkey1.pem"
  }
}

resource "aws_security_group" "name" {
    name = "prom-sec"
    ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


}

resource "aws_instance" "prom" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.ssh_key_name
    security_groups = ["prom-sec"]

    tags = {
      "Name" = var.instance_name
    }

    root_block_device {
        volume_size = var.storage_size
    }

    provisioner "local-exec" {
    command = "echo ${self.public_ip} >> private_ips.txt"
  }
  
}
