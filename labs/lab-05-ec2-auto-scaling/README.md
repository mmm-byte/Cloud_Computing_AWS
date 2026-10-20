# Lab 5: EC2 Auto Scaling

**Course:** Cloud Computing (SMU)  
**Module:** [5 - ELB and Auto Scaling](../../modules/05-elb-and-auto-scaling/)  
**Author:** Mahindra Guptha Kotha  
**Proof of work:** add the submitted lab PDF to [`proof/`](proof/) (see the note below)

> Screenshots from the original submission are not embedded in this page. The submitted PDF in `proof/` contains them. Account IDs, access keys and passwords have been redacted from the text.

---

EXERCISE 10.1
Create a Launch Template
In this exercise, you'll create a launch template that installs and configures a simple web server. You'll then use the launch template to manually create an instance.
         1. In the EC2 service console, click Launch Templates.

         2. Click the Create Launch Template button.

         3. Give the launch template a name such as MyTemplate.

         4. Click the Search For AMI link to locate one of the Ubuntu Server LTS AMIs. If you're in the us-east-1 region, you can use ami-0ac019f4fcb7cb7e6.

         5. For Instance Type, select t2.micro.

         6. Under Security Groups, select a security group that allows inbound HTTP access. Create a new security group if necessary.

Creating a VPC for Security group

         7. Expand the Advanced Details section and enter the following in the User Data text field:
#!/bin/bash
    apt-get update
    apt-get install -y apache2
    echo "Welcome to my website"> index.html
    cp index.html /var/www/html

         8. Click the Create Launch Template button.

         9. Click the Launch Instance From This Template link.

         10. Click the Launch Instance From Template button.

         11. After the instance boots, browse to its public IP address. You should see a web page that says “Welcome to my website.”

         12. Terminate the instance when you're done with it.
