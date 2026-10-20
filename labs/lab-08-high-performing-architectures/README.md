# Lab 8: High-Performing Architectures

| | |
|---|---|
| **Module** | [Module 8: Serverless Computing](../../modules/08-serverless-lambda/) |
| **Services** | EC2 Auto Scaling, S3, CloudFormation, CloudWatch |
| **Proof of work** | [lab-08-high-performing-architectures.pdf](proof/lab-08-high-performing-architectures.pdf) (11 pages, redacted) |

## Objective
Improve availability and performance with automatic scaling, geographic replication, faster uploads, infrastructure as code and monitoring.

## Exercises completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 11.1 | Configure and launch an application with Auto Scaling | Created a launch configuration and an Auto Scaling group with scaling policies |
| 11.2 | Sync two S3 buckets as cross-region replicas | Automatic copying of objects to a second Region for resilience |
| 11.3 | Upload to S3 with Transfer Acceleration | Faster long-distance uploads through edge locations |
| 11.5 | Create a nested stack | Composed a CloudFormation stack from smaller stacks |
| 11.6 | Create a CloudWatch dashboard | Combined key metrics in one view |

The lab manual skips Exercise 11.4.

## Key points
- An Auto Scaling group keeps capacity within a minimum and maximum and replaces unhealthy instances.
- Cross-region replication protects against a Regional failure and brings data closer to users.
- Transfer Acceleration helps most when clients are far from the bucket's Region.
- Nested stacks keep large templates modular and reusable.
- Dashboards turn raw metrics into something a team can check at a glance.

## Scope note
Although this lab belongs to the serverless module, it does not use Lambda. Lambda is covered in the course material only.

## Related
Module guides: [Serverless](../../modules/08-serverless-lambda/), [ELB and Auto Scaling](../../modules/05-elb-and-auto-scaling/), [Infrastructure as Code](../../modules/10-infrastructure-as-code/).
