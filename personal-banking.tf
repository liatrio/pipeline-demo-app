terraform {
        backend "s3" {
        bucket = "liatristorage"
        key = "liatristorage/personal-banking-terraform.tfstate"
        region = "us-west-2"
    }
}

provider "aws" {
    region = "us-west-2"
}

variable "key_file" {
  description = "key for terraform remote provisioners supplied by jenkin"
}

variable "tag" {
    description = "tag for personal-banking image"
    default = "1.2.0-SNAPSHOT"
}

variable "instance_name" {
    description = "This is used to run the personal banking"
}

variable "ami_id" {
    default = "ami-6df1e514"
    description = "AMI used for amazon linux"
}


data "terraform_remote_state" "network" {
    backend = "s3"
    config {
        bucket = "liatristorage"
        key = "liatristorage/${terraform.workspace}/${var.instance_name}-terraform.tfstate"
        region = "us-west-2"
    }
}

resource "aws_instance" "personal-banking-env" {
    instance_type           = "t2.micro"
    key_name                = "jenkins.liatr.io"
    ami                     = "${var.ami_id}"
    security_groups         = ["web", "https server"]

    tags = {
      Name = "${var.instance_name}"
    }


    provisioner "remote-exec" {
      connection {
        user        = "ec2-user"
        private_key = "${file("${var.key_file}")}"
      }
      inline = [
        "sudo yum update -y",
        "sudo yum install -y docker",
        "sudo service docker start",
        "sudo usermod -aG docker ec2-user",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/admins >> ~/.ssh/authorized_keys",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_vets >> ~/.ssh/authorized_keys",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_wave_3 >> ~/.ssh/authorized_keys",
        "curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/jenkins.pub >> ~/.ssh/authorized_keys"
      ]
    }
}

data "aws_route53_zone" "liatrio" {
  name = "liatr.io"
}

resource "aws_route53_record" "personal-banking-env" {
  zone_id = "${data.aws_route53_zone.liatrio.zone_id}"
  name    = "${var.instance_name}.personal-banking.liatr.io"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.personal-banking-env.public_ip}"]
}
