# terraform taint
# Debugging

Run: 
export TF_LOG=ERROR 
export TF_LOG_PATH=/tmp/ProjectA.log

Then run command such as terraform init; terraform apply inside the directory called /root/terraform-projects/ProjectA

cat /tmp/ProjectA.log

terraform untaint aws_instance.ProjectB

# Terraform Import

The command used to create this key is 

aws ec2 create-key-pair --endpoint http://aws:4566 --key-name jade --query 'KeyMaterial' --output text > /root/terraform-projects/project-jade/jade.pem.

The private key is created in the same configuration directory we have been working on.


aws ec2 describe-instances --endpoint http://aws:4566

aws ec2 describe-instances --endpoint http://aws:4566  --filters "Name=image-id,Values=ami-082b3eca746b12a89" | jq -r '.Reservations[].Instances[].InstanceId'

Here is the command to fetch the id of the resource: -

aws ec2 describe-instances --endpoint http://aws:4566  --filters "Name=image-id,Values=ami-082b3eca746b12a89" | jq -r '.Reservations[].Instances[].InstanceId'

terraform import aws_instance.jade-mw id-of-the-resource
terraform import aws_instance.jade-mw i-0f7e0deef8539445f

You can use the jq tool to display the details of a specific resource instance from the terraform show command.

We are doing this for the jade-mw instance.

terraform show -json | jq '.values.root_module.resources[] | select(.type == "aws_instance" and .name == "jade-mw")'

aws ec2 describe-instances --filters "Name=tag:Name,Values=jade-mw" --query "Reservations[*].Instances[*].[ImageId, InstanceType, KeyName, Tags]" --endpoint http://aws:4566