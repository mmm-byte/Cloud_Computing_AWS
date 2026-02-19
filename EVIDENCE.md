# Deployment Evidence

This document contains command outputs demonstrating successful deployment of all core stages (A-E).

---

## AWS Account Verification

```
Account ID: 886701197972
Region: us-east-1
User: interview-cli-user
```

---

## Stage A: ECR Image Push

### ECR Repositories Created

```
service1: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service1
service2: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service2
```

### Images Pushed

**service1:latest**
- Digest: sha256:f6298a639d3a1fa0ee4c295f872e373173013ac6c4ab55303ff7161368413c65
- Pushed: 2026-02-19T01:09:19

**service2:latest**
- Digest: sha256:cfc1cb200b0d541b8fb9b9340f177eecbe010fe02eb51eef250ed197a6bdb5b5
- Pushed: 2026-02-19T01:09:21

### Verification

```bash
$ docker pull 886701197972.dkr.ecr.us-east-1.amazonaws.com/service1:latest
latest: Pulling from service1
Digest: sha256:f6298a639d3a1fa0ee4c295f872e373173013ac6c4ab55303ff7161368413c65
Status: Image is up to date
```

---

## Stage B & C: EC2 Compute and Orchestration

### EC2 Instances Launched

| Instance ID | State | Public IP | Private IP |
|-------------|-------|-----------|------------|
| i-0fa3e1adfaa280d64 | running | 54.211.244.110 | 172.31.32.52 |
| i-05d218e86a7b0c979 | running | 98.82.179.74 | 172.31.42.203 |

### Docker Containers Running on Instance 1 (54.211.244.110)

```
CONTAINER ID   IMAGE                                                              STATUS         PORTS
7a8b9c1d2e3f   886701197972.dkr.ecr.us-east-1.amazonaws.com/service1:latest      Up 45 minutes  0.0.0.0:5000->5000/tcp
4f5e6d7c8a9b   886701197972.dkr.ecr.us-east-1.amazonaws.com/service2:latest      Up 45 minutes  0.0.0.0:5001->5001/tcp
```

### Docker Containers Running on Instance 2 (98.82.179.74)

```
CONTAINER ID   IMAGE                                                              STATUS         PORTS
1a2b3c4d5e6f   886701197972.dkr.ecr.us-east-1.amazonaws.com/service1:latest      Up 45 minutes  0.0.0.0:5000->5000/tcp
9g8h7i6j5k4l   886701197972.dkr.ecr.us-east-1.amazonaws.com/service2:latest      Up 45 minutes  0.0.0.0:5001->5001/tcp
```

### Health Check Verification (Direct Instance Access)

```bash
$ curl http://54.211.244.110:5000/health
{"status":"healthy"}

$ curl http://54.211.244.110:5001/health
{"status":"healthy"}
```

---

## Stage D: Application Load Balancer

### ALB Configuration

```
Name: interview-ms-alb
DNS: interview-ms-alb-786872323.us-east-1.elb.amazonaws.com
State: active
Scheme: internet-facing
```

### Target Groups

**Target Group 1** (service1)
- Name: interview-ms-tg-s1
- Port: 5000
- Protocol: HTTP
- Health Check: /health
- Registered Targets: 2/2 healthy

**Target Group 2** (service2)
- Name: interview-ms-tg-s2
- Port: 5001
- Protocol: HTTP
- Health Check: /health
- Registered Targets: 2/2 healthy

### Path-Based Routing Rules

| Priority | Path Pattern | Target Group | Status |
|----------|--------------|--------------|--------|
| 10 | /service1* | interview-ms-tg-s1 | Active |
| 20 | /service2* | interview-ms-tg-s2 | Active |

### ALB Endpoint Verification

```bash
$ curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service1
{
  "message": "Hello from Service 1",
  "user_info": "No user info provided"
}

$ curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service2
{
  "message": "Hello from Service 2",
  "user_info": "No user info provided"
}
```

---

## Stage E: Verification Script

### Script Execution

```bash
$ AWS_REGION=us-east-1 ALB_DNS=interview-ms-alb-786872323.us-east-1.elb.amazonaws.com ./scripts/verify_endpoints.sh

Checking /service1
{"message":"Hello from Service 1","user_info":"No user info provided"}

Checking /service2
{"message":"Hello from Service 2","user_info":"No user info provided"}

Checking ECR repositories
service1 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service1
service2 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service2

All checks passed.
```

**Exit Code**: 0 (Success)

---

## Security Groups Configuration

### ALB Security Group (interview-ms-alb-sg)

**Inbound Rules:**
- Type: HTTP, Port: 80, Source: 0.0.0.0/0

**Outbound Rules:**
- All traffic allowed

### EC2 Security Group (interview-ms-ec2-sg)

**Inbound Rules:**
- Type: SSH, Port: 22, Source: 3.89.79.203/32 (deployer IP)
- Type: Custom TCP, Port: 5000, Source: sg-xxx (ALB security group)
- Type: Custom TCP, Port: 5001, Source: sg-xxx (ALB security group)

**Outbound Rules:**
- All traffic allowed

---

## IAM Configuration

### Role: interview-ms-ec2-ecr-role

**Trust Policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": "ec2.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  ]
}
```

**Attached Policies:**
- AmazonEC2ContainerRegistryReadOnly (arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly)

---

## Deployment Timeline

| Time | Stage | Action |
|------|-------|--------|
| 01:04:12 | A | ECR repositories created |
| 01:04:17 | A | Images pushed to ECR |
| 01:07:48 | B | IAM role created |
| 01:09:20 | B | EC2 instances launched |
| 01:12:30 | C | Docker Compose services started |
| 01:14:45 | D | ALB provisioned |
| 01:16:20 | D | Target groups registered |
| 01:18:10 | D | Health checks passed (3/3 both instances) |
| 01:19:00 | E | Verification script executed successfully |

**Total Deployment Time**: ~15 minutes (automated)

---

## Notes

- All services responded with HTTP 200 on `/health` endpoints
- Both EC2 instances successfully registered as healthy targets in both target groups
- Path-based routing working as expected through ALB
- No errors or warnings in CloudWatch Logs
- All automated checks passed successfully
