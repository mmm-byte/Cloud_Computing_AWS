# DevOps Interview Assessment - Submission

## Candidate Information
- **Date**: February 19, 2026
- **AWS Account**: 886701197972
- **Region**: us-east-1

---

## Solution Overview

This submission demonstrates a complete containerized microservices deployment on AWS using Docker, ECR, EC2, and an Application Load Balancer with path-based routing.

### Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Internet                            │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            │ HTTP :80
                   ┌────────▼───────────┐
                   │  Application LB    │
                   │ (interview-ms-alb) │
                   └──┬──────────────┬──┘
                      │              │
         /service1/*  │              │  /service2/*
                      │              │
            ┌─────────▼───┐    ┌────▼─────────┐
            │  Target     │    │  Target      │
            │  Group 1    │    │  Group 2     │
            │  :5000      │    │  :5001       │
            └─────────┬───┘    └────┬─────────┘
                      │              │
                      │              │
         ┌────────────┴──────────────┴────────────┐
         │                                         │
    ┌────▼────────────┐                ┌──────────▼───────┐
    │  EC2 Instance 1 │                │  EC2 Instance 2  │
    │  t3.micro       │                │  t3.micro        │
    │  Ubuntu 24.04   │                │  Ubuntu 24.04    │
    ├─────────────────┤                ├──────────────────┤
    │  Docker Compose │                │  Docker Compose  │
    │  ┌───────────┐  │                │  ┌────────────┐  │
    │  │ service1  │  │                │  │  service1  │  │
    │  │  :5000    │  │                │  │   :5000    │  │
    │  └───────────┘  │                │  └────────────┘  │
    │  ┌───────────┐  │                │  ┌────────────┐  │
    │  │ service2  │  │                │  │  service2  │  │
    │  │  :5001    │  │                │  │   :5001    │  │
    │  └───────────┘  │                │  └────────────┘  │
    └─────────────────┘                └──────────────────┘
                      │                         │
                      └─────────┬───────────────┘
                                │ ECR Pull
                      ┌─────────▼──────────┐
                      │  Amazon ECR        │
                      │  - service1:latest │
                      │  - service2:latest │
                      └────────────────────┘
```

---

## Implementation Summary

### Stage A: Image Push ✅
- **Repository 1**: `886701197972.dkr.ecr.us-east-1.amazonaws.com/service1`
- **Repository 2**: `886701197972.dkr.ecr.us-east-1.amazonaws.com/service2`
- Both images built for `linux/amd64` using Docker buildx
- Pushed successfully to ECR with latest tag

### Stage B: Compute Layer ✅
- **Instances**: 2 × t3.micro (Ubuntu 24.04 LTS)
- **Instance Profile**: `interview-ms-ec2-profile` with ECR read-only permissions
- Docker Engine installed and enabled via user-data
- Services deployed using Docker Compose

### Stage C: Orchestration ✅
- `docker-compose.yml` deployed to both instances via EC2 user-data
- Service 1 exposed on port 5000
- Service 2 exposed on port 5001
- Both services return HTTP 200 on `/health` endpoint

### Stage D: Networking ✅
- **Load Balancer**: `interview-ms-alb` (Application Load Balancer)
- **Target Group 1**: Routes `/service1*` → port 5000
- **Target Group 2**: Routes `/service2*` → port 5001
- **Security Groups**:
  - ALB SG: Allows inbound 80 from 0.0.0.0/0
  - EC2 SG: Allows port 22 from deployer IP, ports 5000-5001 from ALB only
- Health checks: `/health` endpoint on both services

### Stage E: Verification Script ✅
- Script: `scripts/verify_endpoints.sh`
- Tests:
  - ALB endpoint `/service1` response
  - ALB endpoint `/service2` response
  - ECR repository URIs for both services
- Returns exit code 0 on success, non-zero on failure

---

## Deployment Instructions

### Prerequisites
- AWS CLI configured and authenticated
- Docker Desktop running
- SSH key pair created in us-east-1

### Quick Deploy (1 command)

```bash
cd interview-repo
chmod +x scripts/*.sh

AWS_REGION=us-east-1 \
ACCOUNT_ID=886701197972 \
PUBLIC_IP=$(curl -s ifconfig.me) \
KEY_NAME=interview-key \
PROJECT=interview-ms \
./scripts/deploy_fast.sh
```

**Output includes**:
- ALB DNS name
- EC2 instance public IPs
- ECR image URIs
- SSH commands for instance access

### Running the Verification Script

```bash
AWS_REGION=us-east-1 \
ALB_DNS=<alb-dns-from-deploy> \
./scripts/verify_endpoints.sh
```

---

## Deliverables Checklist

- [x] **README.md**: Architecture diagram, deployment steps, verification instructions (this file)
- [x] **docker-compose.yml**: EC2 compose file with ECR image references
- [x] **scripts/verify_endpoints.sh**: Automated endpoint health check script
- [x] **scripts/deploy_fast.sh**: End-to-end deployment automation
- [x] **scripts/cleanup.sh**: Resource teardown script
- [x] **evidence/**: Command outputs showing deployment success
  - ECR repository URIs
  - EC2 instance details
  - Docker container status
  - ALB curl responses

---

## AWS Resources Created

### Compute
- 2 × EC2 t3.micro instances (Ubuntu 24.04)
- IAM role: `interview-ms-ec2-ecr-role`
- IAM instance profile: `interview-ms-ec2-profile`

### Networking
- Application Load Balancer: `interview-ms-alb`
- Target Group 1: `interview-ms-tg-s1` (port 5000)
- Target Group 2: `interview-ms-tg-s2` (port 5001)
- Security Group: `interview-ms-alb-sg` (ALB)
- Security Group: `interview-ms-ec2-sg` (EC2)
- Listener rules for path-based routing

### Container Registry
- ECR Repository: `service1`
- ECR Repository: `service2`

---

## Cleanup

### Automated Cleanup

```bash
AWS_REGION=us-east-1 PROJECT=interview-ms ./scripts/cleanup.sh
```

This script:
- Terminates EC2 instances
- Deletes ALB and target groups
- Removes security groups
- Deletes IAM instance profile and role

### Manual Verification
After running cleanup script, verify in AWS Console:
- EC2 → Instances (terminated)
- EC2 → Load Balancers (deleted)
- EC2 → Security Groups (interview-ms-* removed)
- IAM → Roles (interview-ms-ec2-ecr-role removed)
- ECR → Repositories (optional: delete if no longer needed)

---

## Cleanup Confirmation

**Status**: All AWS resources provisioned for this assessment have been successfully terminated and removed.

**Date**: February 19, 2026

**Verification**:
- ✅ EC2 instances terminated
- ✅ Application Load Balancer deleted
- ✅ Target Groups deleted
- ✅ Security Groups removed
- ✅ IAM Role and Instance Profile deleted
- ⚠️  ECR repositories retained for reference (minimal cost)

---

## Technical Notes

### Instance Type Selection
- Originally specified: `t2.micro`
- Actually deployed: `t3.micro`
- **Reason**: AWS account restricts t2.micro; deploy script auto-configurable via `INSTANCE_TYPE` environment variable

### Security Considerations
- EC2 SSH access restricted to deployer public IP only
- Service ports (5000, 5001) accessible only from ALB security group
- IAM instance profile uses least-privilege read-only ECR access
- All resources tagged for easy identification and cleanup

### Cost Optimization
- t3.micro instances eligible for free tier (first 750 hours)
- ALB incurs ~$0.025/hour (~$0.60/day)
- ECR storage minimal (<500MB total)
- **Estimated runtime cost**: <$2 for full deployment test cycle

---

## Contact

For questions or clarifications regarding this submission, please reach out via the interview coordination channel.
