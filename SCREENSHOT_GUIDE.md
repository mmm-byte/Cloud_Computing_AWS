# AWS Screenshots Guide

Follow these steps to capture screenshots of your AWS deployment for documentation/submission.

---

## 1. ECR Repositories (Container Registry)

**URL:** https://us-east-1.console.aws.amazon.com/ecr/repositories?region=us-east-1

**What to capture:**
- List showing both repositories: `service1` and `service2`
- Repository URIs visible
- Recent image push timestamps

**Steps:**
1. Sign in to AWS Console
2. Go to ECR > Repositories
3. Ensure both service1 and service2 are visible
4. Take screenshot showing the repository list

---

## 2. ECR Images

**For each repository (service1 and service2):**

**What to capture:**
- Click on repository name
- Show the image with `latest` tag
- Image digest (sha256:...)
- Push date/time
- Image size

**Steps:**
1. Click on `service1` repository
2. Screenshot showing the latest image details
3. Repeat for `service2` repository

---

## 3. EC2 Instances

**URL:** https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#Instances:

**What to capture:**
- Both instances with names: `interview-ms-ec2-1` and `interview-ms-ec2-2`
- Instance IDs: `i-068ab1d36eaec4368`, `i-04c2f2dd95096e66e`
- Instance state: Running
- Instance type: t3.micro
- Public IP addresses visible
- Security group names

**Steps:**
1. Go to EC2 > Instances
2. Filter or search for: `interview-ms`
3. Take screenshot showing both instances

---

## 4. EC2 Instance Details (Optional but recommended)

**For Instance i-068ab1d36eaec4368:**

**What to capture:**
- Click on instance ID
- Details tab showing:
  - Instance type: t3.micro
  - AMI: Ubuntu 24.04
  - IAM role: interview-ms-ec2-profile
  - Security groups
  - Public/Private IPs

---

## 5. Load Balancer (ALB)

**URL:** https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#LoadBalancers:

**What to capture:**
- Load balancer name: `interview-ms-alb`
- DNS name: `interview-ms-alb-786872323.us-east-1.elb.amazonaws.com`
- State: Active
- Scheme: internet-facing
- Availability Zones

**Steps:**
1. Go to EC2 > Load Balancers
2. Click on `interview-ms-alb`
3. Screenshot showing the Description tab

---

## 6. Target Groups

**URL:** https://us-east-1.console.aws.amazon.com/ec2/home?region=us-east-1#TargetGroups:

**What to capture for BOTH target groups:**

### interview-ms-tg-s1 (Service 1)
- Port: 5000
- Health check path: /health
- Registered targets tab showing:
  - Both instances registered
  - Status: **healthy** for both
  - Target IDs visible

### interview-ms-tg-s2 (Service 2)
- Port: 5001
- Health check path: /health
- Registered targets tab showing:
  - Both instances registered
  - Status: **healthy** for both

**Steps:**
1. Go to EC2 > Target Groups
2. Click on `interview-ms-tg-s1`
3. Go to "Targets" tab
4. Screenshot showing healthy targets
5. Repeat for `interview-ms-tg-s2`

---

## 7. ALB Listener Rules

**What to capture:**
- Click on Load Balancer `interview-ms-alb`
- Go to "Listeners" tab
- Click on HTTP:80 listener
- Show the routing rules:
  - `/service1*` → interview-ms-tg-s1
  - `/service2*` → interview-ms-tg-s2

**Steps:**
1. Go to Load Balancers > interview-ms-alb
2. Click "Listeners" tab
3. Click "View/edit rules" for HTTP:80
4. Screenshot showing both path-based routing rules

---

## 8. Security Groups

### ALB Security Group (interview-ms-alb-sg)

**What to capture:**
- Inbound rules showing:
  - HTTP (80) from 0.0.0.0/0
- Outbound rules

**Steps:**
1. Go to EC2 > Security Groups
2. Search for `interview-ms-alb-sg`
3. Click on security group
4. Screenshot "Inbound rules" tab
5. Screenshot "Outbound rules" tab

### EC2 Security Group (interview-ms-ec2-sg)

**What to capture:**
- Inbound rules showing:
  - SSH (22) from specific IPs
  - TCP (5000) from ALB security group
  - TCP (5001) from ALB security group

---

## 9. IAM Role

**URL:** https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/roles

**What to capture:**
- Role name: `interview-ms-ec2-ecr-role`
- Trusted entity: EC2
- Attached policies: 
  - AmazonEC2ContainerRegistryReadOnly

**Steps:**
1. Go to IAM > Roles
2. Search for `interview-ms-ec2-ecr-role`
3. Click on role name
4. Screenshot showing:
   - Trust relationships
   - Permissions policies

---

## 10. IAM Instance Profile

**What to capture:**
- Instance profile name: `interview-ms-ec2-profile`
- Associated role: `interview-ms-ec2-ecr-role`

**Steps:**
1. Go to IAM > Roles
2. Search for `interview-ms-ec2-profile` or view the role details
3. Show the instance profile association

---

## 11. Service Endpoint Testing (Browser Screenshots)

### Service 1 Test
**URL:** http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service1

**What to capture:**
- Browser showing JSON response:
```json
{"message":"Hello from Service 1","user_info":"No user info provided"}
```
- URL visible in address bar

### Service 2 Test
**URL:** http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service2

**What to capture:**
- Browser showing JSON response:
```json
{"message":"Hello from Service 2","user_info":"No user info provided"}
```

---

## 12. Terminal Output (Optional)

You can also take screenshots of:

### Health Check Verification
```bash
curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service1
curl http://interview-ms-alb-786872323.us-east-1.elb.amazonaws.com/service2
```

### Target Group Health Status
```bash
aws elbv2 describe-target-health --region us-east-1 \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:886701197972:targetgroup/interview-ms-tg-s1/f10736a7d70abea4
```

---

## Screenshot Organization Tips

Create a folder structure:
```
screenshots/
├── 01-ecr-repositories.png
├── 02-ecr-service1-images.png
├── 03-ecr-service2-images.png
├── 04-ec2-instances-list.png
├── 05-ec2-instance-details.png
├── 06-alb-overview.png
├── 07-target-group-s1-healthy.png
├── 08-target-group-s2-healthy.png
├── 09-alb-listener-rules.png
├── 10-security-group-alb.png
├── 11-security-group-ec2.png
├── 12-iam-role.png
├── 13-service1-browser-test.png
└── 14-service2-browser-test.png
```

---

## Most Important Screenshots (Priority Order)

If you're short on time, capture these in order:

1. ✅ **Both target groups showing HEALTHY status** (proves services are working)
2. ✅ **Browser tests of both service endpoints** (proves ALB routing works)
3. ✅ **EC2 instances running** (proves compute is deployed)
4. ✅ **ECR repositories with images** (proves containers are stored)
5. ✅ **Load balancer active** (proves ALB is configured)
6. Security groups (proves network configuration)
7. IAM role (proves permissions are set)
8. Listener rules (proves routing is configured)

---

## Quick Access Commands

Use these commands to get information quickly:

```bash
# Get instance IDs and IPs
aws ec2 describe-instances --region us-east-1 \
  --filters "Name=tag:Project,Values=interview-ms" \
  --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress,State.Name]' \
  --output table

# Get ALB DNS
aws elbv2 describe-load-balancers --region us-east-1 \
  --names interview-ms-alb \
  --query 'LoadBalancers[0].DNSName' \
  --output text

# Get target health for service1
aws elbv2 describe-target-health --region us-east-1 \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:886701197972:targetgroup/interview-ms-tg-s1/f10736a7d70abea4

# Get target health for service2
aws elbv2 describe-target-health --region us-east-1 \
  --target-group-arn arn:aws:elasticloadbalancing:us-east-1:886701197972:targetgroup/interview-ms-tg-s2/be6aff2c7a3c7cb1
```

---

**Good luck with your screenshots! 📸**
