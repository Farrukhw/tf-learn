terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

variable "region" {
  type=string
  default="ap-south-1"
}

variable "amis" {
  type = map
  default={
    "ap-south-1" = "ami-0a4a70bd98c6d6441"
  }
}



resource "aws_instance" "example" {
  // ami           = "ami-08f63db601b82ff5f"
  //Amazon Linux 2 AMI (HVM), SSD Volume Type - ami-08f63db601b82ff5f (64-bit x86) / ami-0e502bbbe5de26d28 (64-bit Arm)

   //ami           = "ami-0a4a70bd98c6d6441"  
   ami           = var.amis["ap-south-1"]
   //Ubuntu Server 20.04 LTS (HVM), SSD Volume Type - ami-0a4a70bd98c6d6441 (64-bit x86) / ami-00e24e2d9b2d70f5c (64-bit Arm)

  instance_type = "t2.micro"
  vpc_security_group_ids  = ["sg-a058e4d9"]
  subnet_id = "subnet-f58a979d"
}


resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ami" {
  value = aws_instance.example.ami
}

output "ip" {
  value = aws_eip.ip.public_ip
}
