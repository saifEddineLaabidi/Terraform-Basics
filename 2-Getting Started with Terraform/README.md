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

The HCL file consists of blocks and arguments. A block is defined within curly braces and it contains a set of arguments in key value pair format representing the configuration data. But what is a block and what arguments does it contain? In its simplest form, a block in Terraform contains information about the infrastructure platform and a set of resources within that platform that we want to create.

![ScreenShot](/assets/hclbaiscs5.PNG)

Terraform supports many Providers and each provider has its own resource type and in that resource type, they have their own argument. We do not need to memorize it we can simply check the documentation provided by the hashi corp.

Here is an example of a resource file created for provisioning and **AWS EC2 instance**. The resource type is **aws_instance**. We name the resource **web server** and the arguments that we have used here is the **ami id** and the **instance type**.

![ScreenShot](/assets/hclbaiscs1.PNG)

Here is another example of a **resource file** used to create an **AWS S3 bucket**. The resource type in this case is **aws_s3_bucket**. The **resource name** that we have chosen is **data** and the arguments that we have provided is the **bucket name** and the **ACL**.

![ScreenShot](/assets/hclbaiscs3.PNG)

A simple Terraform workflow consists of four steps. First, write the configuration file. Next, run the **Terraform init** command and after that, review the execution plan using the **Terraform plan** command. Finally, once we are ready, apply the changes using the **Terraform apply** command.

![ScreenShot](/assets/hclbaiscs4.PNG)

This command will check the **configuration file** and **initialize** the working directory containing the **.tf file**. One of the first things that this command does is to understand that we are making use of the **local provider** based on the **resource type** declared in the resource block. It will then **download the plug in** to be able to work on the resources declared in the **.tf file**. From the output of this command, we can see that **Terraform init** has installed a plug in called local. 

![ScreenShot](/assets/hclbaiscs6.PNG)

Next, we are ready to create the resource. But before we do that, if we want to see the **execution plan** that will be carried out by Terraform, we can use the command **Terraform plan**. This command will show the actions that will be carried out by Terraform to create the resource. 
The output has a plus symbol next to the local file type resource called pet. This includes all the arguments that we specified in the.tf file for creating the resource. But you'll also notice that some default or optional arguments, which we did not specifically declare in the configuration file is also displayed on the screen. The plus symbol implies that the **resource will be created**. Now remember, this step will not create the infrastructure resource yet. This information is provided for the user to review and ensure that all the actions to be performed in this execution plan is desired.

![ScreenShot](/assets/hclbaiscs7.PNG)

After the review, we can create the resource. To do this, we will make use of the **Terraform apply** command. This command will display the execution plan once again, and it will then ask the user to confirm by typing yes to proceed. Once we confirm, it will proceed with the creation of the resource, which in this case, is a file

![ScreenShot](/assets/hclbaiscs8.PNG)

We can also run the **terraform show** command within the configuration directory to see the details of the resource that we just created. This command **inspects the state file** and displays the resource details.

![ScreenShot](/assets/hclbaiscs9.PNG)

**How do you know what types of resources are available?** 
**How do you know what arguments are expected by the resource?**

Earlier, we mentioned that Terraform supports over 100 providers. for examples **AWS** to deploy resources in **Amazon AWS Cloud**, **Azure**, **GCP** ,etc . Each of these providers have a **unique list of resources** that can be created on that specific platform. Each resource can have a number of **required or optional arguments** that are needed to create that resource.

![ScreenShot](/assets/hclbaiscs10.PNG)

# Update and Destroy Infrastructure

![ScreenShot](/assets/hclbaiscs11.PNG)

![ScreenShot](/assets/hclbaiscs12.PNG)

![ScreenShot](/assets/hclbaiscs13.PNG)

![ScreenShot](/assets/hclbaiscs14.PNG)

![ScreenShot](/assets/hclbaiscs15.PNG)
