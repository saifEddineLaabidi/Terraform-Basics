# More Terraform Functions
# Conditional Expressions
You can either do this in the interactive console or a one liner like this:

echo 'aws_iam_user.cloud[6].name' | terraform console
# Terraform Workspaces (OSS)

You can list the workspace by running the following command: 
terraform workspace list

terraform workspace new us-payroll
terraform workspace new uk-payroll
terraform workspace new india-payroll

terraform workspace select us-payroll

Run: 
terraform workspace select us-payroll; terraform apply

then 
terraform workspace select uk-payroll; terraform apply

and finally 
terraform workspace select india-payroll; terraform apply (In any order)