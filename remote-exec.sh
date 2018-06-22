#! /bin/bash

sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -aG docker ec2-user
curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/admins >> ~/.ssh/authorized_keys
curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_vets >> ~/.ssh/authorized_keys
curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/chico_wave_3 >> ~/.ssh/authorized_keys
curl https://s3-us-west-2.amazonaws.com/liatrio-authorized-keys-groups/jenkins.pub >> ~/.ssh/authorized_keys
