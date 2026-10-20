# DevOps Assessment: Containerized Microservices on AWS

Lift-and-shift of two Flask microservices from local Docker to AWS.

- Assignment brief: [ASSESSMENT_BRIEF.md](ASSESSMENT_BRIEF.md)
- Full write-up with diagram and cleanup confirmation: [SUBMISSION.md](SUBMISSION.md)
- Command output and evidence: [EVIDENCE.md](EVIDENCE.md), [screenshots/](screenshots/)

## Architecture

```
Internet --> ALB (:80)
              |-- /service1* --> Target group :5000 --+
              |-- /service2* --> Target group :5001 --+
                                                      v
                    2 x EC2 (Ubuntu 24.04), each running Docker Compose:
                    service1 (:5000) and service2 (:5001)
                                                      ^
                                    images pulled from Amazon ECR
```

Region: `us-east-1`.

## Layout

| Path | Purpose |
|---|---|
| `servers/` | The two Flask services, their Dockerfiles and a local compose file |
| `docker-compose.yml` | Compose file used on the EC2 instances (images from ECR) |
| `scripts/deploy_fast.sh` | Creates ECR repos, pushes images, IAM profile, security groups, EC2 instances and the ALB |
| `scripts/verify_endpoints.sh` | Curls both ALB routes and checks the ECR repositories; exits non-zero on failure |
| `scripts/cleanup.sh` | Tears down the AWS resources |

## Run it

```bash
chmod +x scripts/*.sh
AWS_REGION=us-east-1 ACCOUNT_ID=<your-account-id> PUBLIC_IP=$(curl -s ifconfig.me) \
KEY_NAME=<your-key-pair> PROJECT=interview-ms ./scripts/deploy_fast.sh

AWS_REGION=us-east-1 ALB_DNS=<alb-dns-from-output> ./scripts/verify_endpoints.sh
AWS_REGION=us-east-1 PROJECT=interview-ms ./scripts/cleanup.sh
```

## Related coursework
[Module 2: EC2](../../modules/02-compute-ec2-ebs-efs/), [Module 4: Networking](../../modules/04-networking-vpc-route53-cloudfront/), [Module 5: ELB and Auto Scaling](../../modules/05-elb-and-auto-scaling/)

## Known gaps
- The Auto Scaling group and Terraform bonus is not built.
- The user-data script installs Docker but does not install the AWS CLI it calls for the ECR login; test on a fresh instance and add the install step if it fails.
- `EVIDENCE.md` mixes two sets of instance IDs and IPs; replace it with output from a single run.
