# Installing Terraform

In this part, we will learn how to install Terraform. Terraform can be downloaded as a single binary, or an executable file, from the Terraform download section in www.terraform.io.

```sh
$ wget https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip
$ unzip terraform_0.13.0_linux_amd64.zip
$ mv terraform /usr/local/bin
$ terraform version
Terraform v0.13.0
```

# HCL – Declarative Language

 We can now start deploying resources using Terraform. As stated earlier, Terraform uses configuration files which are written in HCL to deploy infrastructure resources. These files have a **.tf** extension

```hcl
resource "aws_instance" "webserver" {
ami = "ami-0c2f25c1f66a1ff4d"
instance_type = "t2.micro"
}
```

# Resource
**What is a resource?** 
A resource is an object that Terraform manages. It could be a file on a local host, or it could be a virtual machine on the Cloud, such as an EC2 instance, or it could be services like S3 buckets, ECS, DynamoDB tables, IM users, or IM groups, roles, policies, etc. Or it could be resources on major Cloud providers such as the Compute and App Engine from GCP, databases on Azure Active Directory, etc. There are literally hundreds of resources that can be provisioned across most of the Cloud and on-premise infrastructure using Terraform. 

![ScreenShot](/assets/ressources.png)

# HCL Basics

```sh
$ mkdir /root/terraform-local-file
$ cd /root/terraform-local-file
```
```hcl
resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content = "We love pets!"
}
```

Here in the above HCL the **"resource"** is the **Block Name**, **"local_file"** is the **Resource Type**, and **"pet"** is the **resource name**.

The **filename** and **content** in the block are called an **argument**.

![ScreenShot](/assets/hclbaiscs.PNG)

![ScreenShot](/assets/hclbaiscs1.PNG)