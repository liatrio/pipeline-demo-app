#!/bin/bash
workspace=$(dirname 0)

# initialize the workspace
#this is necessary for using remote state storage
terraform init -input=false

#create workspace
export TF_WORKSPACE=$TF_VAR_instance_name

#create and switch to a new workspace
terraform workspace new $TF_VAR_instance_name

# destroy the instance
terraform destroy -input=false -auto-approve=true

exit $EXIT_STATUS
