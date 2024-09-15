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
