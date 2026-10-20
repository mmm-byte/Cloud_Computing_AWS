# Lab 5: EC2 Auto Scaling (Launch Templates)

| | |
|---|---|
| **Module** | [Module 5: Resource Management and Scheduling](../../modules/05-elb-and-auto-scaling/) |
| **Services** | EC2, launch templates, VPC, security groups |
| **Proof of work** | [lab-05-ec2-auto-scaling.pdf](proof/lab-05-ec2-auto-scaling.pdf) (10 pages, redacted) |

## Objective
Create the building block that Auto Scaling depends on: a launch template that configures an instance automatically at boot.

## Exercise completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 10.1 | Create a launch template and launch an instance from it | Selected an Ubuntu Server LTS AMI and `t2.micro`, attached a security group that allows HTTP, and used user data to install Apache and publish a welcome page |

## How it works
The launch template stores the AMI, instance type, security group and a user data script. The script runs once at first boot:

```bash
#!/bin/bash
apt-get update
apt-get install -y apache2
echo "Welcome to my website" > index.html
cp index.html /var/www/html
```

After the instance booted, browsing to its public IP address returned the welcome page. The instance was terminated afterwards. A VPC was created to host the security group used by the template.

## Key points
- User data turns a generic AMI into a configured server with no manual steps.
- An Auto Scaling group uses a launch template to create identical instances on demand, so this lab is the first half of a scaling setup.
- Because every instance is built the same way, instances can be replaced instead of repaired.

## Related
Module guide: [ELB and Auto Scaling](../../modules/05-elb-and-auto-scaling/). The scaling group itself is built in [Lab 8](../lab-08-high-performing-architectures/), Exercise 11.1.
