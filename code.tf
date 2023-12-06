terraform {

  required_providers {

    github = {

      source = "integrations/github"

    }

    aws = {

      source = "hashicorp/aws"
      version = "~>3.0"

    }

  }

}



provider "aws" {

  region = "ap-south-1"

}



provider "github" {

  token = "gittoke,"

}



resource "aws_instance" "my_server" {

  instance_type        = "t2.micro"

  ami                  = "ami-02a2af70a66af6dfb" #amazon_linux_distro

  key_name             = "newone"

  availability_zone    = "ap-south-1b"

  hibernation          = true

  root_block_device {

    encrypted   = true

    volume_size = 10

  }

  tags = {
    Name = chinna_basha
  }



  ebs_block_device {

    device_name             = "/dev/sdb"

    volume_size             = 8

    encrypted               = true

    delete_on_termination   = true

  }

  provisioner "local-exec" {
    command = "echo the servers name is ${self.tags.Name} >> ~/name.txt"
    
  }

}



resource "github_repository" "my_git_repo" {

  name        = "terraform_git"

  visibility  = "public"

  description = "Git repository created using Terraform"

}



output "aws_attributes" {
    value = aws_instance.my_server 
  
}
