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

# Amazon Machine Images
# “t2.micro": This is an instance type with modest resources (1 vCPU and 1 GB RAM), suitable for tests, small projects or low-load applications.
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

Terraform is a popular **IaC tool**, which is specifically useful as an infrastructure provisioning tool. Terraform is a free and open-source tool, which is developed by Hashicorp. It installs as a single binary, which can be **set up very quickly, allowing us to build, manage, and destroy infrastructure in a matter of minutes**.

Terraform offers extensive support for various **cloud providers**, allowing organizations to manage infrastructure across different environments seamlessly, enabling multi-cloud or hybrid strategies.

HCL supports a **declarative approach** to infrastructure provisioning. This is also the reason to learn and use Terraform as it is easy to understand also.

![ScreenShot](/assets/terraform-1.png)

# HashiCorp Configuration Language

Terraform uses HCL, which stands for Hashicorp Configuration Language, which is a simple **declarative language** to define the infrastructure resources to be provisioned as blocks of code. All infrastructure resources can be defined within configuration files that has **a.tf** file extension. The configuration syntax is easy to read and write and pick up for a beginner. This sample code is used to provision a new EC2 instance on the AWS Cloud.

**main.tf**
```hcl
resource "aws_instance" "webserver" {
ami = "ami-0edab43b6fa892279"
instance_type = "t2.micro"
}

resource "aws_s3_bucket" "finance" {
  bucket = "finanace-21092020"
  tags = {
    Description = "Finance and Payroll"
  }
}

resource "aws_iam_user" "admin-user" {
  name = "lucy"
  tags = {
    Description = "Team Leader"
  }
}
```

# Terraform Workflow

![ScreenShot](/assets/Terraformworkflow.PNG)

Terraform works in three phases, **init**, **plan**, and **apply**. 

During the **init phase**, Terraform initializes the project and identifies the providers to be used for the target environment. 

During the **plan phase**, Terraform drafts a plan to get to the target state and then 

in the **apply phase**, Terraform makes the necessary changes required on the target environment to bring it to the desired state.

# Terraform State

![ScreenShot](/assets/TerraformState.PNG)

The **Terraform State** is central to the operation of Terraform. It stores information about the infrastructure provisioned by Terraform in **order to monitor and manage** its state over time. Here's a detailed explanation: 

### What is the Terraform State?

The **Terraform State** is a file, usually named **`terraform.tfstate`**, which contains a representation of the infrastructure as provisioned by Terraform. It plays a crucial role in aligning the configuration described in the **.tf files** (Terraform code) with the **actual state of the infrastructure** on cloud services or servers.

### Why is Terraform State important?

1. Infrastructure monitoring:

Terraform compares the current state of the infrastructure (stored in the state file) with the configuration declared in the code. This enables Terraform to determine the actions to be taken, such as creating, updating or deleting resources.

2. Change detection :

If you change your Terraform configuration (for example, by modifying a parameter or adding a resource), Terraform compares this change with the status file and determines the modifications required to synchronize the infrastructure.

3. Improved performance:

Terraform uses state to avoid querying cloud APIs on every command. Instead of constantly asking for the current state of resources, it uses the state file as a reference, optimizing the management of large infrastructures.

4. Teamwork:

The status file can be stored centrally, for example in a backend such as S3 (for AWS) or Azure Blob Storage (for Azure), so that several people can work simultaneously on the infrastructure while sharing the same status.

### Example of the contents of the terraform **`.tfstate file`**:

``` json 
{
  "version": 4,
  "terraform_version": "1.0.3",
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "webserver",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "attributes": {
            "ami": "ami-0edab43b6fa892279",
            "instance_type": "t2.micro",
            "tags": {
              "Name": "Web Server"
            }
          }
        }
      ]
    }
  ]
}

```
This file describes :

The Terraform version used.
The resources created (such as an EC2 “webserver” instance), their attributes (such as AMI and instance type), and their state.

### Where is Terraform State stored?

1. Locally: By default, the terraform.tfstate file is stored in the same directory as the .tf configuration files. This is useful for small projects or if you're working alone.

2. Distant backends: For more complex environments or teams, we recommend storing the state in a remote backend such as :

*  Amazon S3
* Google Cloud Storage
* Azure Blob Storage
* Consul
* Terraform Cloud

### Terraform Import

![ScreenShot](/assets/importtrf.png)

In Terraform, the **terraform import** command lets you **import existing resources** into your Terraform configuration without having to recreate them. Basically, if you already have infrastructure (e.g. virtual machines, databases, networks, etc.) managed outside Terraform, this command lets you integrate these resources into Terraform code.

```terraform
terraform import <type_de_ressource>.<nom_de_la_ressource> <identifiant_de_la_ressource>
terraform import aws_instance.example i-12345678
```