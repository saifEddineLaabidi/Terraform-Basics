# Using Terraform Providers

When we run terraform init within a directory containing the configuration files, Terraform downloads and installs plugins for the providers used within the configuration. These can be plugins for cloud providers such as AWS, GCP, Azure. Terraform uses a plugin based architecture to work with hundreds of such infrastructure platforms. Terraform providers are distributed by Hashicorp and are publicly available in the terraform registry.

![ScreenShot](/assets/provider1.PNG)

At the URL registry.terraform.io , there are three tiers of providers 

The first one is the official provider. These are owned and maintained by HashiCorp and include the major cloud providers such as AWS, GCP and Azure. The local provider that we have used so far is also an official provider.

The second type of provider is a partner provider. A partner provider is owned and maintained by a third party technology company that has gone through a partner provider process with Hashicorp. Some of the examples are the big IP provider from FI Networks, Heroku, DigitalOcean, et cetera. 

And finally, we have the community providers that are published and maintained by individual contributors of the Hashicorp community.

![ScreenShot](/assets/provider2.PNG)

```hcl
terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "1.0.4"
    }
  }
}


terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.13.3"
    }
  }
}

```

# Configuration Directory

Apart from **main.tf** we can create many other files which have their own purpose for making them more manageable and readable.

such as the **variables TF**, **outputs TF** and **providers TF**. We will talk more about these files in the later sections of this course.

![ScreenShot](/assets/conf.PNG)

# Multiple Providers 

Terraform also supports the use of **multiple providers** within the same configuration. To illustrate this, let's make use of another provider called **random**. This provider allows us to create random resources, such as a random ID, a random integer, a random password, etc. Let us see how to use this provider and create a resource called random pet. This resource type will generate a random pet name when applied. By making use of the documentation, we can add a resource block to the existing main.TF file like this. Here, we are making use of the resource type called random pet

This resource is often used to generate unique random names for resources such as instances, buckets or clusters, and avoid name collisions in your infrastructure.

![ScreenShot](/assets/MultipleProviders1.PNG)
![ScreenShot](/assets/MultipleProviders2.PNG)
![ScreenShot](/assets/MultipleProviders3.PNG)

```hcl
resource "aws_instance" "ec2_instance" {
	  ami       =  "ami-0eda277a0b884c5ab" 
	  instance_type = "t2.large"
}

resource "aws_ebs_volume" "ec2_volume" {
	  availability_zone = "eu-west-1"
	  size  =    10
}

resource "kubernetes_namespace" "dev" {
  metadata {
    name = "development"
  }
}

```

# Define Input Variables

**`variables.tf`**, is where we define the input variables for your Terraform configuration. In this file, we define the variables, their types, default values, and any constraints or validation rules.

There are many types of variables in terraforming:

![ScreenShot](/assets/var3.PNG)

variables make Terraform code more flexible, maintainable and easily adaptable to different contexts and reusable and modifiable without having to change the source code each time.

By using variables in this example, you refer to these values dynamically with var.filename and var.content. If you need to change the value of filename or content, simply modify the variables in a separate file, or pass them as parameters when running Terraform. This allows you to factorise and parameterise the code without modifying the main file.

![ScreenShot](/assets/var1.PNG)

![ScreenShot](/assets/var2.PNG)

1. **List Variable**

List variables allow us to define an ordered collection of values. Lists are enclosed in square brackets [] and can contain elements of any type, including strings, numbers, or even other lists.

![ScreenShot](/assets/var4.PNG)

2. **Map Variables**

Map variables enable us to define a collection of key-value pairs. Maps are enclosed in curly braces {}, and the keys and values can be of any type.

![ScreenShot](/assets/var5.PNG)

3. **List of a Type**

![ScreenShot](/assets/var6.PNG)

4. **Map of a Type**

![ScreenShot](/assets/var7.PNG)

5. **Set**

In Terraform, the set type is a collection containing only unique elements, in no specific order. It guarantees that each value in the group is present only once, without duplication.

![ScreenShot](/assets/var8.PNG)

6. **Objects**

![ScreenShot](/assets/var10.PNG)

7. **Tuples**

A tuple in Terraform is a collection of values whose type and position are fixed. Unlike a list, where all elements must be of the same type, a tuple allows different types to be combined, while maintaining the order of the elements.

![ScreenShot](/assets/var9.PNG)

# Using Variables in Terraform

1. **Interactive Mode**

In interactive mode, Terraform variables can be supplied by the user at runtime

![ScreenShot](/assets/vars1.PNG)

If no value is specified, Terraform will ask the user to enter values for these variables when run with the terraform apply or terraform plan command.

![ScreenShot](/assets/vars2.PNG)

2. **Command Line Flags**

you can pass variable values directly on the command line

![ScreenShot](/assets/vars3.PNG)

3. **Environment Variables**

By using the TF_VAR_ export commands, you define environment variables which Terraform can use directly without having to request them interactively or pass values with -var

![ScreenShot](/assets/vars4.PNG)

+ Environment variables allow you to pass values to Terraform variables without including them directly in the .tf file or using .tfvars files.

+ Useful for automating deployments in CI/CD environments or for configuring Terraform scripts without modifying the configuration files.

4. **Variable Definition Files**

You can also store the values of the variables in a **`.tfvars`** file and pass it at runtime.

![ScreenShot](/assets/vars5.PNG)

The **`.auto.tfvars`** and **`.auto.tfvars.json`** files are very useful for defining variable values automatically and without explicit user intervention when executing Terraform commands. They facilitate the management of variables, especially in automated environments.

![ScreenShot](/assets/vars6.PNG)

# Variable Definition Precedence**

The order of precedence for variable sources is as follows with later sources taking precedence over earlier ones:

![ScreenShot](/assets/ordrevar.PNG)

# Resource Attribute Reference

We can also use the reference as an attribute in the resources block. We can look at which attribute it is returning and use it according to using the command $(resource_type.reource_name.attribute)

+ **Resource Attribute Reference**: Allows values from one resource to be used in another resource.

+ **Order of Operations**: Terraform understands the dependencies between resources and will create them in the correct order. For example, it will first generate the pet name (random_pet.my-pet) before creating the file (local_file.pet) which uses this name.

+ This mechanism ensures that resources are interconnected and that their attributes can be managed and referenced dynamically.

+ The value of random_pet.my-pet.id is generated dynamically when the random_pet resource is created. Terraform replaces this value in the content of the local_file resource.

![ScreenShot](/assets/varref.PNG)

# Resource Dependencies

1. **Implicit Dependency**

![ScreenShot](/assets/implicite.PNG)

In Terraform, implicit dependencies are automatically deduced by the Terraform engine as a function of connections between resources via variables or attributes; it is not necessary to explicitly declare a dependency using **`depends_on`**.

```hcl
provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example_a" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}

resource "aws_instance" "example_b" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example_a.id
}
```

2. **Explicit Dependency**

![ScreenShot](/assets/explicite.PNG)

An explicit dependency in Terraform is defined manually using the **`depends_on`** field. It is used to force Terraform to execute a resource after one or more other resources, even if there is no direct relationship via variables or attributes.

```hcl
resource "aws_s3_bucket" "example" { }

resource "aws_instance" "example_c" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  depends_on = [aws_s3_bucket.example]
}

module "example_sqs_queue" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "3.3.0"

  depends_on = [aws_s3_bucket.example, aws_instance.example_c]
}

```

# Output Variables

**Output variables** in Terraform are used to expose or share information generated by a Terraform configuration. They are often used to display useful results after the execution of a plan or an application, or to pass values from one module to another.

![ScreenShot](/assets/output.PNG)

![ScreenShot](/assets/output1.PNG)

![ScreenShot](/assets/output3.PNG)
