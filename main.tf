terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "todo_app_ec2" {
  ami                    = "ami-0eb378c01632b2c17"
  instance_type          = "t3.nano"
  availability_zone      = "us-east-1a"
  key_name               = "thb"
  monitoring             = false
  
  network_interface {
    network_interface_id = aws_network_interface.todo_interface.id
    device_index         = 0
  }
}

# Ausgabe von IP Adresse
output "server_public_ip" {
   value = aws_eip.todo_ip.public_ip
 }