# AWS Cloud Skills: Coursework, Labs and Projects

A portfolio and study guide from my Cloud Computing course at SMU (Spring 2025) plus a hands-on deployment project. It pairs short **module guides** with the **labs** I completed, and a **capstone-style project** that applies them end to end.

**Author:** Mahindra Guptha Kotha

## How this repo is organized

```
modules/    Study guide, one page per course module (concepts, services, links to labs)
labs/       My lab write-ups (steps performed) and a proof/ folder for each submitted PDF
projects/   Applied work, starting with the DevOps assessment (ECR, EC2, Docker Compose, ALB)
```

## Skills at a glance

| Area | AWS services | Module | Evidence |
|---|---|---|---|
| Identity and access | IAM users, groups, policies, MFA, access keys, permissions boundaries, assumed roles | [1](modules/01-iam/) | [Lab 1](labs/lab-01-iam/), [Lab 7](labs/lab-07-secure-architectures/) |
| Compute | EC2, AMIs, launch templates, AWS CLI launches | [2](modules/02-compute-ec2-ebs-efs/) | [Lab 2](labs/lab-02-ec2/), [Lab 5](labs/lab-05-ec2-auto-scaling/) |
| Storage and databases | S3 (versioning, lifecycle, presigned URLs, static hosting, replication, Transfer Acceleration), RDS with read replicas, DynamoDB | [3](modules/03-storage-and-databases/) | [Lab 3](labs/lab-03-storage-and-databases/), [Lab 8](labs/lab-08-high-performing-architectures/) |
| Networking | VPC, subnets, ENIs, internet gateway, security groups, Elastic IP, transit gateway, Route 53 (health checks, failover), CloudFront, VPC Flow Logs | [4](modules/04-networking-vpc-route53-cloudfront/) | [Lab 4](labs/lab-04-vpc-route53-cloudfront/), [Lab 7](labs/lab-07-secure-architectures/) |
| Scaling and load balancing | Auto Scaling, Application Load Balancer | [5](modules/05-elb-and-auto-scaling/) | [Lab 8](labs/lab-08-high-performing-architectures/), [DevOps project](projects/devops-assessment/) |
| Monitoring and audit | CloudTrail, CloudWatch metrics, logs and dashboards | [6](modules/06-monitoring-sns-sqs/) | [Lab 6](labs/lab-06-cloudtrail-cloudwatch-config/), [Lab 8](labs/lab-08-high-performing-architectures/) |
| Security | Permissions boundaries, role assumption, flow logs, EBS encryption | [7](modules/07-cloud-security/) | [Lab 7](labs/lab-07-secure-architectures/) |
| Serverless | Lambda (course coverage; no lab yet) | [8](modules/08-serverless-lambda/) | Not yet demonstrated |
| Big data and streaming | Redshift, EMR, Kinesis, Kafka (course coverage) | [9](modules/09-big-data-and-streaming/) | Research report |
| Infrastructure as code | CloudFormation nested stack | [10](modules/10-infrastructure-as-code/) | [Lab 8](labs/lab-08-high-performing-architectures/), research report |
| Architecture | Architectural kata | [11](modules/11-architectural-kata/) | Kata report and presentation |
| Containers and delivery | Docker, ECR, ALB, shell automation | [DevOps project](projects/devops-assessment/) | Scripts, screenshots, evidence |

## Featured project

[**DevOps assessment**](projects/devops-assessment/): lift-and-shift of two containerized microservices to AWS with ECR, EC2, Docker Compose and an Application Load Balancer, driven by scripted deploy, verify and cleanup steps.

## Proof of work
Each lab folder has a `proof/` directory for the PDF I submitted. Sensitive values (account IDs, keys, passwords) are redacted in the write-ups; see [labs/README.md](labs/README.md).

## Roadmap
- [ ] Add the submitted lab PDFs to each `labs/*/proof/` folder
- [ ] Add the research reports and the kata report/slides
- [ ] Rebuild the DevOps project with Terraform or CloudFormation, plus an Auto Scaling group (min 2, desired 2, max 4, scale out on CPU > 40%)
- [ ] Add architecture diagrams to each module guide
