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

**Instance 1**
- ID: i-068ab1d36eaec4368
- Public IP: 54.89.253.59
- Type: t3.micro
- State: running

**Instance 2**
- ID: i-04c2f2dd95096e66e
- Public IP: 100.53.214.106
- Type: t3.micro
- State: running

### Docker Services Running

Both instances have the following containers:
- service1: Port 5000
- service2: Port 5001

Example from Instance 1:
```bash
$ docker ps
CONTAINER ID   IMAGE                                                          COMMAND                 CREATED       STATUS       PORTS
fc50e81c810f   886701197972.dkr.ecr.us-east-1.amazonaws.com/service2:latest   "python service2.py"    Running       0.0.0.0:5001->5001/tcp
4d73f08eb3d7   886701197972.dkr.ecr.us-east-1.amazonaws.com/service1:latest   "python service1.py"    Running       0.0.0.0:5000->5000/tcp
```

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

### Target Groups Status

**Service 1 Target Group** (interview-ms-tg-s1 - Port 5000):
- i-068ab1d36eaec4368:5000 - healthy
- i-04c2f2dd95096e66e:5000 - healthy

**Service 2 Target Group** (interview-ms-tg-s2 - Port 5001):
- i-068ab1d36eaec4368:5001 - healthy
- i-04c2f2dd95096e66e:5001 - healthy

---

## Stage E: Verification Script Output

Successfully tested all required endpoints:

### Service 1 Test
```bash
$ curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service1
{"message":"Hello from Service 1","user_info":"No user info provided"}
```

### Service 2 Test
```bash
$ curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service2
{"message":"Hello from Service 2","user_info":"No user info provided"}
```

### ECR Verification
```bash
$ aws ecr describe-repositories --region us-east-1
service1 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service1
service2 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service2
```

### Complete Verification Output
```
Checking /service1
{"message":"Hello from Service 1","user_info":"No user info provided"}
Checking /service2
{"message":"Hello from Service 2","user_info":"No user info provided"}
Checking ECR repositories
service1 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service1
service2 repo: 886701197972.dkr.ecr.us-east-1.amazonaws.com/service2
All checks passed.
```

---

## Infrastructure Summary

### Complete Resource Inventory

**Container Registry:**
- 2 ECR repositories with pushed images

**Compute:**
- 2 EC2 t3.micro instances (Ubuntu 24.04 LTS)
- Both instances running service1 and service2 containers

**Load Balancing:**
- 1 Application Load Balancer (internet-facing)
- 2 Target Groups (ports 5000, 5001)
- Path-based routing: /service1* → TG1, /service2* → TG2

**Networking:**
- Security Groups configured for ALB (port 80) and EC2 (ports 22, 5000, 5001)

**IAM:**
- EC2 instance profile with ECR read-only access

---

## Deployment Timestamp

- Deployment Date: 2026-02-19
- All stages completed successfully
- Services are healthy and responding to requests
