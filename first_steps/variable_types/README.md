# Variable loading priority

1. terraform apply -var "filename=sample.txt
2. variable.auto.tfvars file
3. terraform.tfvars file
4. export TF_VAR_filename="sample.txt"
