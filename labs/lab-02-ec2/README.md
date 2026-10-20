# Lab 2: EC2

| | |
|---|---|
| **Module** | [Module 2: Virtualization and Compute](../../modules/02-compute-ec2-ebs-efs/) |
| **Services** | EC2, EBS, AMIs, launch templates, AWS CLI |
| **Proof of work** | [lab-02-ec2.pdf](proof/lab-02-ec2.pdf) (24 pages, redacted) |

## Objective
Work through the EC2 lifecycle: launch an instance, right-size it, choose a pricing model, capture it as an image, automate launches, and clean up.

## Exercises completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 2.1 | Launch a Linux instance | Selected an Amazon Linux AMI and a `t2.micro` instance type in the console |
| 2.2 | Assess free capacity and change the instance type | Checked utilization of a running instance and resized it |
| 2.3 | Compare pricing models | Matched On-Demand, Reserved and Spot pricing to the needs of a deployment |
| 2.4 | Create an AMI from an existing instance | Captured an instance's storage volume as a reusable image and launched from it |
| 2.5 | Create a launch template | Defined instance settings once so launches are repeatable |
| 2.6 | Install the AWS CLI and launch an instance with it | Automated an EC2 launch from the command line |
| 2.7 | Clean up unused EC2 resources | Removed instances and related resources to avoid ongoing charges |

## Key points
- Instance type, AMI and security group are the three choices that define a launch.
- AMIs and launch templates turn a one-off server into a repeatable one, which is the basis for Auto Scaling.
- Pricing model matters as much as instance size: steady workloads suit Reserved capacity, interruptible work suits Spot.
- Unused volumes, snapshots and Elastic IPs keep billing after instances are stopped, so cleanup is part of every lab.

## Related
Module guide: [Compute (EC2, EBS, EFS)](../../modules/02-compute-ec2-ebs-efs/). Launch templates return in [Lab 5](../lab-05-ec2-auto-scaling/).
