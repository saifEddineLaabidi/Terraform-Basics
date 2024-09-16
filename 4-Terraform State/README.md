# Introduction to Terraform State

when the Terraform plan command is run, The very first line that is printed when we run this command shows that Terraform tries to ** refresh the state in memory prior to the plan**. Since it's the first time we're running the Terraform plan command, there will be no details related to state printed, therefore, implying that there is no state recorded at this moment in time. From this, Terraform also understands that currently there are no resources provision based on the configuration files and then creates an execution plan of create

![ScreenShot](/assets/state/state1.PNG)

Moving on, let us now run Terraform apply. This command also tries to refresh the in memory state, finds that there is no state recorded at the moment, and then proceeds to create an execution plan. Once confirmed Terraform creates the local file resource as expected. Terraform creates a **unique ID for the resource** as seen in the command output. As expected, we can see that the file has been created with the content that we provided.

![ScreenShot](/assets/state/state2.PNG)

**Now, what will happen if we run the Terraform apply command again?**
Terraform knows that a local file resource by the name of PET and the same ID that we just saw already exists, and it takes no further action. 

![ScreenShot](/assets/state/state3.PNG)

**How does Terraform know that? How does it know that the local file resource already exist?**

the terraform state file, which was created as a consequence of the Terraform apply command that created the resource in the first place. This file is not created until the Terraform apply command is run at least once. **The state file is a JSON data structure** that maps the real world infrastructure resources to the resource definition in the configuration files. If we inspect the contents of this state file, we can see that it has the complete record of the infrastructure created by Terraform. In this case, we have a single resource of type local file, and a logical name called PET. The details such as the resource ID, provider information, and all the resource attributes are stored within this file. **It contains every little detail pertaining to the infrastructure that was created by Terraform**, and it uses it as a single source of truth when using commands such as Terraform plan and apply.

![ScreenShot](/assets/state/state4.PNG)

# Purpose of State

# Terraform State Considerations 

1. Sensitive Data
2. No Manual Edits
3. Terraform State Considerations

