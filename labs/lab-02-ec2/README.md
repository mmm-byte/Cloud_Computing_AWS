# Lab 2: EC2

**Course:** Cloud Computing (SMU)  
**Module:** [2 - EC2, EBS and EFS](../../modules/02-compute-ec2-ebs-efs/)  
**Author:** Mahindra Guptha Kotha  
**Proof of work:** add the submitted lab PDF to [`proof/`](proof/) (see the note below)

> Screenshots from the original submission are not embedded in this page. The submitted PDF in `proof/` contains them. Account IDs, access keys and passwords have been redacted from the text.

---

Exercise 2.1 will guide you through the launch of a simple EC2 Linux instance.
1. From the EC2 Dashboard, click to launch a new instance and select a Linux AMI and instance type. Remember, the t2.micro is Free Tier–eligible if your AWS account is still within its first year.
Login to AWS USING ROOT USER. Then Search EC2 on that dashboard click launch instance.

Select Amazon Linux and t2.micro instance type which are already set in default

2. Explore the Network Settings, Configure Storage, and Advanced sections—although the default settings should work fine.
Checking the Network settings, Configuration storage and advanced sections.

3. In the Network Settings section, make sure there's a rule permitting incoming SSH (port 22) traffic. It should be there by default. You can create your own security group or select an existing group by clicking the Edit button. Default settings will all normally work well here.
In network settings going with default creating security group and since it is default the SSH is also in port 22.  Click launch instance.

4. Before letting you launch the instance, AWS will require you to select—or create—a key pair. Follow the instructions.
A dialogue box appears saying select the key pair since we have not created one before we are creating one, so give it a name. Click Launch instance.

5. Once the instance is launched, you can return to the Instances Dashboard to wait a minute or two until everything is running properly.

6. Click the Actions pull-down menu and select Connect for instructions on how to connect to the instance from your local machine. Note how the SSH username will vary, for instance, between Linux distributions (like Ubuntu or Amazon Linux).Then connect and take a look at your virtual cloud server.
Go to instances and select the created instance → Action drop down → connect.

A dialogue box appears saying connect to instance and all the EC2 instance related settings. Click Connect.

A new tab opens with the AWS linux cloud server.

EXERCISE 2.2
Assess the Free Capacity of a Running Instance and Change Its Instance Type
1. With an instance running, open the Instances Dashboard in the EC2 console. Select the instance you're interested in and click the Monitoring tab in the bottom half of the screen. That's a good place to see what percentage of compute and network resources you've been using over the past hours or weeks.
Now pretend that your instance is nearly maxed out and change the instance type as follows
Go to EC2 instance → select the running instance → click on Monitoring under the instance to look at resources utilization.

   2. Stop the instance using the Instance State drop-down menu. (Remember, unless you're using an elastic IP address for instance, your public IP address might be different when you start up again.)
Drop down under instance state and click stop instance

   3. From the Actions drop-down menu, click Instance Settings and then Change Instance Type (which might only appear after a minute or so or once you refresh the page). Select a new type (although remember that choosing a non–Free Tier instance type might incur costs).
Click on Action drop down → Instance settings → Change instance type

Select the instances that are free tier eligible.

   4. Restart the instance and confirm that it's running properly.
Click on instance state drop down and click start instance.

EXERCISE 2.3
Assess Which Pricing Model Will Best Meet the Needs of a Deployment
Imagine that your application will need to run two always-on f1.2xlarge instances (which come with instance storage and won't require any EBS volumes). To meet seasonal demand, you can expect to require as many as four more instances for a total of 100 hours through the course of a single year. How should you pay for this deployment?

Bonus: Calculate your total estimated monthly and annual costs.
EXERCISE 2.4
Create and Launch an AMI Based on an Existing Instance Storage Volume

   1. If necessary, launch an instance (following the instructions displayed when you click the Connect menu item at the top) and make at least some token change to the root volume. This could be something as simple as typing touch test.txt on a Linux instance to create an empty file.

   2. Create an image from the instance's volume (you'll access the dialog box by using the Actions pull-down menu and then clicking Image And Templates in the instance's dashboard).

Give the name for the image and click on create.

   3. Launch an instance from the console and select the new AMI from the My AMIs tab.

Click on instance → launch instance → give name to instance → select my AMI’s .

Click launch instance

   4. Log into the instance and confirm that your previous change has persisted.

EXERCISE 2.5
Create a Launch Template
In this exercise, you'll create a launch template that installs and configures a simple web server. You'll then use the launch template to manually create an instance.
   1. In the EC2 Dashboard, click Launch Templates.

   2. Click the Create Launch Template button.

   3. Give the launch template a name such as MyTemplate.

   4. Click inside the search field for an image and select the AMI of one of the Ubuntu Server LTS AMIs (make sure the AMI you choose uses the 64-bit x86 architecture and not 64-bit ARM).

   5. For Instance Type, select t2.micro.

   6. Under Network Settings, select a security group that allows inbound HTTP access. Create a new security group if necessary.

Expand the Advanced Details section and scroll down to the User Data field. Enter the following:
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo "Welcome to my website"> index.html
    cp index.html /var/www/html

   7. Click the Create Launch Template button.

   8. Click the Launch Instance From This Template link.
Under Action drop menu → Click Launch instance from this template link

   9. Under Source Template Version, select 1 (Default).

   10. Click the Launch Instance From Template button.

   11. After the instance boots, browse to its public IP address. You should see a web page that says “Welcome to my website.”

   12. Terminate the instance when you're done with it.

EXERCISE 2.6
Install the AWS CLI and Use It to Launch an EC2 Instance
Need help? Learn how to install the AWS CLI for your OS here:
[http://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
Refer to the previous AWS CLI example for help launching your instance. (Hint: You will need to fill in some xxxxx placeholders with actual resource IDs.)

EXERCISE 2.7
Clean Up Unused EC2
Since you've probably been launching resources while experimenting with AWS, you'll want to make sure you haven't accidentally left anything running that could cost you money. So, take a good look through the console and kill off what shouldn't still be alive. Here are some things to consider:
   * Remember to check any other AWS regions where you might have done some work—only a single region's resources will show up in the console at a time.
   * Some resources can't be deleted because they're in use by other resources. A snapshot used by a private AMI is one example. You'll need to shut those down in the right order.
   * When you're logged into your AWS root account, you can check out your Billing and Cost Management dashboard in the console (http://console.aws.amazon.com/billing). This dashboard will show you whether, taking into account your current resource usage, you stand to run up a bill in the current month.
