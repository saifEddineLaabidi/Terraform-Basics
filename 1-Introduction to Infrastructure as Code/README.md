# Challenges with Traditional IT Infrastructure

![ScreenShot](/assets/Capture.PNG)

Let's consider an organization that wants to roll out a new application. The business comes up with the requirements for the application. The business analyst then gathers the needs from the business, analyzes it, and converts it into a set of high level technical requirements. This is then passed onto a solution architect. The solution architect then designs the architecture to be followed for the deployment of this application. This would typically include the infrastructure considerations, such as the type, spec, and count of servers that are needed, such as those for frontend web servers, backend servers, databases, load balances, et cetera. Following the traditional infrastructure model, these would have to be deployed in the organizations on-premise environment, which would mean making use of the assets in the data center. If additional hardware is needed, they would have to be audited via the procurement team. This team will put in a new hardware request with the vendors. It can then take anywhere between a few days to weeks or even months for the hardware to be purchased and delivered to the data center. Once received at the data center, the field engineers would be in charge of rack and stack of the equipment. The system administrators perform initial configurations, and the network administrators make the systems available on the network. The storage admins assign storage to the servers and the backup admins configure backups. Finally, once the systems have been set up as per the standards, they can then be handed over to the application teams to deploy their applications. 

Traditional IT infrastructure can pose several challenges for organizations, particularly as they scale or seek to innovate. Here are some common issues:

1. **Scalability**: Traditional IT infrastructures are often rigid and not easily scalable. Scaling up typically requires significant capital investment in hardware, which can be time-consuming and costly.

2. **Cost**: Maintaining traditional IT infrastructure involves high upfront costs for hardware, software licenses, and data center space. Additionally, ongoing maintenance, upgrades, and energy consumption add to the operational expenses.

3. **Flexibility**: Legacy systems are often inflexible, making it difficult to adapt to new business requirements or technological advancements. This can slow down innovation and hinder the ability to respond to market changes.

4. **Complexity**: Managing traditional IT infrastructure involves dealing with complex systems and a mix of hardware and software from different vendors. This complexity can lead to higher chances of errors, longer deployment times, and more difficult troubleshooting.

5. **Downtime**: Traditional IT environments often rely on single points of failure, which can lead to significant downtime in the event of hardware failures, maintenance, or unexpected outages. This can impact business continuity and service delivery.

6. **Security**: Legacy systems may lack the advanced security features needed to protect against modern cyber threats. Keeping them secure requires constant patching, monitoring, and updates, which can be resource-intensive.

7. **Disaster Recovery**: Implementing effective disaster recovery solutions can be challenging and expensive with traditional IT infrastructure. It often involves setting up and maintaining redundant systems, which can be inefficient and costly.

8. **Speed of Deployment**: Deploying new applications or services in a traditional IT environment can be slow, as it often requires procuring and setting up new hardware, configuring networks, and ensuring compatibility with existing systems.

9. **Vendor Lock-in**: Traditional IT infrastructure often involves reliance on specific vendors for hardware and software. This can limit flexibility and negotiating power, leading to higher costs and difficulties in adopting new technologies.

10. **Environmental Impact:** Traditional data centers consume large amounts of energy and have a significant carbon footprint. Organizations increasingly face pressure to adopt more sustainable practices, which traditional infrastructure may not support effectively.

In the past decade or so, organizations have been moving to virtualization and Cloud platforms to take advantages of services provided by major Cloud providers, such as **Amazon AWS**, **Microsoft Azure**, **Google Cloud Platform**. By moving to Cloud, the time to spin up the infrastructure and the time to market for applications are significantly reduced. This is because with Cloud, you do not have to invest in or manage the actual hardware assets that normally would in case of a traditional infrastructure model. The data center, the hardware assets, and the services are managed by the Cloud provider. A virtual machine can be spun up in a Cloud environment in a matter of minutes, and the time to market is reduced from several months, as in the case of a traditional infrastructure to weeks in a Cloud environment. Infrastructure costs are reduced when compared with the additional data center management and human resources cost. Cloud infrastructure comes with support for APIs, and that opens up a whole new world of opportunity for automation. Finally, the built-in autoscaling and elastic functionality of Cloud infrastructure reduces resource wastage. With virtualization and Cloud, you could now provision infrastructure with a few clicks. While this approach is certainly faster and more efficient when compared to the traditional deployment methods, using the management console for resource provisioning is not always the ideal solution. It is okay to have this approach when we are dealing with limited number of resources. But in a large organization with elastic and highly scalable cloud environment with immutable infrastructure, this approach is not feasible.

Once provision, the systems still have to go through different teams with a lot of process overhead that increases the delivery time. The chances of human error are still at large, resulting in inconsistent environments. Different organizations started solving these challenges within themselves by developing their own scripts and tools. While some use simple shell scripts, others use programming languages such as Python, Ruby, Pearl, or Powershell. Everyone was solving the same problems, trying to **automate infrastructure** provisioning, to deploy environments faster, and in a consistent fashion by leveraging the API functionalities of the various Cloud environments. These evolved into a set of tools that came to be known as **infrastructure as code**. In the next lecture, we will see what infrastructure as code is in more detail.

# Infrastructure as Code

![ScreenShot](/assets/maxresdefaul.jpg)

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
With **infrastructure as code** you can manage nearly any infrastructure component as code, such as databases, networks, storage, or even application configuration. The code you see here is a shell script. However, it is not easy to manage it. It requires programming or development skills to build and maintain. There's a lot of logic that you will need to code and it is not easily reusable. And that's where tools like terraform and ansible help with code that is easy to learn, is human, readable and maintained. **A large shell script can now be converted into a simple terraform configuration file** like this. With infrastructure as code, we can define infrastructure resources using simple, human readable, high level language. 

**main.tf**
```hcl
resource "aws_instance" "webserver" {
  ami           = "ami-0edab43b6fa892279"
  instance_type = "t2.micro"
}
```
This code is an example of how to use the amazon.aws.ec2 module in Ansible, an infrastructure automation tool, to create and manage EC2 instances on AWS.
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