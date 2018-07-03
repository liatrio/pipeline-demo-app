#!/bin/bash
workspace=$(dirname 0)

# initialize the workspace
#this is necessary for using remote state storage
terraform init -input=false -no-color

#create workspace
export TF_WORKSPACE=$TF_VAR_instance_name

#create and switch to a new workspace
terraform workspace new $TF_VAR_instance_name -no-color

#create the tfplan
terraform plan -out=tfplan -input=false -no-color

# initialize the instance
terraform apply -input=false tfplan -no-color

exit $EXIT_STATUS
