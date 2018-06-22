terraform {
        backend "s3" {
        key = "liatristorage/personal-banking-terraform.tfstate"
        region = "us-west-2"
    }
}

provider "aws" {
    region = "us-west-2"
}

variable "instance_name" {
    description = "This is used to run the personal banking app"
}

variable "ami_id" {
    default = "ami-6df1e514"
    description = "AMI used for amazon linux"
}

data "terraform_remote_state" "network" {
    backend = "s3"
    config {
        bucket = "liatristorage"
        key = "liatristorage/personal-banking-terraform.tfstate"
        region = "us-west-2"
    }
}

resource "aws_instance" "personal-banking-env" {
    instance_type           = "t2.micro"
    key_name                = "jenkins.liatr.io"
    ami                     = "${var.ami_id}"
    security_groups         = ["web", "https server"]

    tags = {
      Name = "${var.instance_name}",
      Uptime = "critical"
    }

    provisioner "remote-exec" {
      connection {
        user        = "ec2-user"
        private_key = "${file("~/.ssh/id_rsa")}"
      }
      inline = [
        "sudo yum update -y",
        "sudo yum install -y docker",
        "sudo service docker start",
        "sudo usermod -aG docker ec2-user",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/admins >> ~/.ssh/authorized_keys",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_vets >> ~/.ssh/authorized_keys",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_wave_3 >> ~/.ssh/authorized_keys",
      ]
    }
}
