# Module 2: Virtualization and Compute (EC2, EBS, EFS)

**Lab:** [Lab 2: EC2](../../labs/lab-02-ec2/)

## What this module covers
- How virtualization works (hypervisors, virtual machines) and why it underpins the cloud.
- **EC2:** virtual servers on demand.
- **EBS:** block storage attached to a single instance.
- **EFS:** shared, elastic file storage mounted over NFS.

## Key concepts
| Concept | One-line summary |
|---|---|
| AMI | Template used to launch an instance |
| Instance type | CPU, memory and network profile (for example `t3.micro`) |
| Key pair | SSH credentials for logging in to Linux instances |
| Security group | Stateful virtual firewall around an instance |
| EBS volume | Persistent block device, tied to one Availability Zone, snapshot-able |
| EFS | Network file system that many instances can mount at once |
| AWS Nitro System | Dedicated hardware and lightweight hypervisor behind modern EC2 (research topic) |

## Hands-on (Lab 2)
Launched a Linux instance, checked free capacity and changed its instance type, compared pricing models, created an AMI from an existing instance, created a launch template, installed the AWS CLI and launched an instance from it, and cleaned up unused EC2 resources (Exercises 2.1 to 2.7).

## Course materials
- Slides: Virtualization, EC2, EBS and EFS
- Discussion: Ossified operating systems
- Research and report: The AWS Nitro System
- Quiz: Compute services
