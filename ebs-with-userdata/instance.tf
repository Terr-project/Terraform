terraform {
  required_providers {
    aws = {
      version = "~> 5.27.0"
    }
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "ebs_instance_example" {
  ami           = lookup(var.ami_id, var.region)
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id

  # Security group assign to instance
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  # key name
  key_name = var.key_name
  # User data passing through template rendering
  user_data = data.template_file.init.rendered

  tags = {
    Name = "EBS with userdata"
  }
}
