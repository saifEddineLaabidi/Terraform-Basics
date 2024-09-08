# Infrastructure as Code

![ScreenShot](/assets/maxresdefaul.jpg)

Historically, IT infrastructure was administered through manual processes, where IT operations personnel were responsible for setting up and upholding resources like servers, storage, and networking devices. However, **this method was labor-intensive , prone to errors, and not easily scalable**. It also presented difficulties in maintaining uniformity across multiple environments, such as development, testing, and production.

In today's fast-paced digital world, software development and deployment have become increasingly complex and demanding. To keep up with the ever-evolving technology landscape, organizations are adopting **DevOps practices** to streamline their software development and deployment processes.**One key aspect of DevOps is Infrastructure as Code (IAC), which involves managing infrastructure in a programmable manner using code.**

IaC involves using either **declarative** or **imperative code** to automate the deployment, configuration, and management of infrastructure components, such as servers, networks, storage, and applications. With IaC, infrastructure is defined in code, just like software applications are defined in code, and can be version controlled, tested, and audited.

# Declarative vs. Imperative Infrastructure As Code

1. **Imperative code**: You give detailed step-by-step instructions for creating or modifying resources, showing exactly how the infrastructure is to be provisioned.

The code you see here is a **shell script**. However, it is not easy to manage it. It requires programming or development skills to build and maintain. There's a lot of logic that you will need to **code and it is not easily reusable**.

**ec2.sh**
```sh
#!/bin/bash
IP_ADDRESS="10.2.2.1"
EC2_INSTANCE=$(ec2-run-instances --instance-type
t2.micro ami-0edab43b6fa892279)
INSTANCE=$(echo ${EC2_INSTANCE} | sed 's/*INSTANCE //'
| sed 's/ .*//')
# Wait for instance to be ready
while ! ec2-describe-instances $INSTANCE | grep -q
"running"
do
echo Waiting for $INSTANCE is to be ready...
done
# Check if instance is not provisioned and exit
if [ ! $(ec2-describe-instances $INSTANCE | grep -q
"running") ]; then
echo Instance $INSTANCE is stopped.
exit
fi
ec2-associate-address $IP_ADDRESS -i $INSTANCE
echo Instance $INSTANCE was created successfully!!!
```
![ScreenShot](/assets/ec2.PNG)

2. **Declarative code**: You specify the desired end state, and the tool (like Terraform) takes care of creating or modifying the resources to achieve this state. You don't give precise instructions on how to do it.

A voluminous shell script can now be converted into a simple terraform configuration file like this one, easy to learn, readable and maintainable.

**main.tf**
```hcl
resource "aws_instance" "webserver" {
  ami           = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}
```
In this example:

You declare that you want an **AWS instance** with a specific **AMI image** and **instance type** **“t2.micro”**.

Terraform will analyze the current state of your infrastructure, compare it with what is declared and apply the necessary changes to create this instance if it doesn't already exist.

Here is another example where we'll be making use of Ansible to provision three AWS EC2 instances making use of a specific AMI.

```yml
- amazon.aws.ec2:
    key_name: mykey
    instance_type: t2.micro
    image: ami-123456
    wait: yes
    group: webserver
    count: 3
    vpc_subnet_id: subnet-29e63245
    assign_public_ip: yes
```

# Types of IAC Tools

![ScreenShot](/assets/Capture1.PNG)

# Why Terraform?

