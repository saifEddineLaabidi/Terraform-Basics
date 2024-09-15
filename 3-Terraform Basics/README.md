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

1. List Variable

List variables allow us to define an ordered collection of values. Lists are enclosed in square brackets [] and can contain elements of any type, including strings, numbers, or even other lists.

![ScreenShot](/assets/var4.PNG)

2. Map Variables

Map variables enable us to define a collection of key-value pairs. Maps are enclosed in curly braces {}, and the keys and values can be of any type.

![ScreenShot](/assets/var5.PNG)

3. List of a Type

![ScreenShot](/assets/var6.PNG)

4. Map of a Type

![ScreenShot](/assets/var7.PNG)

5. Set

In Terraform, the set type is a collection containing only unique elements, in no specific order. It guarantees that each value in the group is present only once, without duplication.

![ScreenShot](/assets/var8.PNG)

6. Objects

![ScreenShot](/assets/var10.PNG)

7. Tuples

A tuple in Terraform is a collection of values whose type and position are fixed. Unlike a list, where all elements must be of the same type, a tuple allows different types to be combined, while maintaining the order of the elements.

![ScreenShot](/assets/var9.PNG)





