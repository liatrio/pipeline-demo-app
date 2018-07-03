#!/bin/bash
workspace=$(dirname 0)

# initialize the workspace
#this is necessary for using remote state storage
terraform init -input=false -no-color

#create workspace
export TF_WORKSPACE=$TF_VAR_instance_name

# destroy the instance
terraform destroy -force -no-color

exit $EXIT_STATUS
