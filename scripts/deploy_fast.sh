#!/usr/bin/env bash
set -euo pipefail
export AWS_PAGER=""

AWS_REGION="${AWS_REGION:-us-east-1}"
ACCOUNT_ID="${ACCOUNT_ID:?Set ACCOUNT_ID}"
PUBLIC_IP="${PUBLIC_IP:?Set PUBLIC_IP (without /32)}"
KEY_NAME="${KEY_NAME:-interview-key}"
PROJECT="${PROJECT:-interview-ms}"
INSTANCE_TYPE="${INSTANCE_TYPE:-t3.micro}"

SERVICE1_REPO="service1"
SERVICE2_REPO="service2"
SERVICE1_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE1_REPO}"
SERVICE2_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE2_REPO}"

ALB_SG_NAME="${PROJECT}-alb-sg"
EC2_SG_NAME="${PROJECT}-ec2-sg"
ROLE_NAME="${PROJECT}-ec2-ecr-role"
PROFILE_NAME="${PROJECT}-ec2-profile"
ALB_NAME="${PROJECT}-alb"
TG1_NAME="${PROJECT}-tg-s1"
TG2_NAME="${PROJECT}-tg-s2"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVERS_DIR="${ROOT_DIR}/servers"

echo "[1/10] Resolving networking defaults..."
VPC_ID="$(aws ec2 describe-vpcs --region "$AWS_REGION" --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId' --output text)"
if [[ -z "$VPC_ID" || "$VPC_ID" == "None" ]]; then
  echo "No default VPC found in ${AWS_REGION}. Create one or set up a VPC first."
  exit 1
fi
SUBNET_IDS=( $(aws ec2 describe-subnets --region "$AWS_REGION" --filters Name=vpc-id,Values="$VPC_ID" Name=default-for-az,Values=true --query 'Subnets[].SubnetId' --output text) )
if (( ${#SUBNET_IDS[@]} < 2 )); then
  echo "Need at least 2 default subnets in ${AWS_REGION} for ALB."
  exit 1
fi

echo "[2/10] Ensuring ECR repositories exist..."
aws ecr describe-repositories --region "$AWS_REGION" --repository-names "$SERVICE1_REPO" >/dev/null 2>&1 || \
  aws ecr create-repository --region "$AWS_REGION" --repository-name "$SERVICE1_REPO" >/dev/null
aws ecr describe-repositories --region "$AWS_REGION" --repository-names "$SERVICE2_REPO" >/dev/null 2>&1 || \
  aws ecr create-repository --region "$AWS_REGION" --repository-name "$SERVICE2_REPO" >/dev/null

echo "[3/10] Logging into ECR and building images..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

docker buildx build --platform linux/amd64 -t "${SERVICE1_URI}:latest" "${SERVERS_DIR}/service1" --load
docker buildx build --platform linux/amd64 -t "${SERVICE2_URI}:latest" "${SERVERS_DIR}/service2" --load

echo "[4/10] Pushing images to ECR..."
docker push "${SERVICE1_URI}:latest"
docker push "${SERVICE2_URI}:latest"

echo "[5/10] Creating security groups..."
ALB_SG_ID="$(aws ec2 describe-security-groups --region "$AWS_REGION" --filters Name=group-name,Values="$ALB_SG_NAME" Name=vpc-id,Values="$VPC_ID" --query 'SecurityGroups[0].GroupId' --output text)"
if [[ "$ALB_SG_ID" == "None" ]]; then
  ALB_SG_ID="$(aws ec2 create-security-group --region "$AWS_REGION" --group-name "$ALB_SG_NAME" --description "ALB SG" --vpc-id "$VPC_ID" --query GroupId --output text)"
  aws ec2 authorize-security-group-ingress --region "$AWS_REGION" --group-id "$ALB_SG_ID" --ip-permissions '[{"IpProtocol":"tcp","FromPort":80,"ToPort":80,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}]' || true
fi

EC2_SG_ID="$(aws ec2 describe-security-groups --region "$AWS_REGION" --filters Name=group-name,Values="$EC2_SG_NAME" Name=vpc-id,Values="$VPC_ID" --query 'SecurityGroups[0].GroupId' --output text)"
if [[ "$EC2_SG_ID" == "None" ]]; then
  EC2_SG_ID="$(aws ec2 create-security-group --region "$AWS_REGION" --group-name "$EC2_SG_NAME" --description "EC2 SG" --vpc-id "$VPC_ID" --query GroupId --output text)"
  aws ec2 authorize-security-group-ingress --region "$AWS_REGION" --group-id "$EC2_SG_ID" --ip-permissions "[{\"IpProtocol\":\"tcp\",\"FromPort\":22,\"ToPort\":22,\"IpRanges\":[{\"CidrIp\":\"${PUBLIC_IP}/32\"}]},{\"IpProtocol\":\"tcp\",\"FromPort\":5000,\"ToPort\":5000,\"UserIdGroupPairs\":[{\"GroupId\":\"${ALB_SG_ID}\"}]},{\"IpProtocol\":\"tcp\",\"FromPort\":5001,\"ToPort\":5001,\"UserIdGroupPairs\":[{\"GroupId\":\"${ALB_SG_ID}\"}]}]" || true
fi

echo "[6/10] Ensuring IAM role/profile for EC2 ECR pull..."
if ! aws iam get-role --role-name "$ROLE_NAME" >/dev/null 2>&1; then
  cat > /tmp/${ROLE_NAME}-trust.json <<'JSON'
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
JSON
  aws iam create-role --role-name "$ROLE_NAME" --assume-role-policy-document file:///tmp/${ROLE_NAME}-trust.json >/dev/null
  aws iam attach-role-policy --role-name "$ROLE_NAME" --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly >/dev/null
fi

if ! aws iam get-instance-profile --instance-profile-name "$PROFILE_NAME" >/dev/null 2>&1; then
  aws iam create-instance-profile --instance-profile-name "$PROFILE_NAME" >/dev/null
  sleep 5
  aws iam add-role-to-instance-profile --instance-profile-name "$PROFILE_NAME" --role-name "$ROLE_NAME" >/dev/null
fi
PROFILE_ARN="$(aws iam get-instance-profile --instance-profile-name "$PROFILE_NAME" --query 'InstanceProfile.Arn' --output text)"
sleep 15

echo "[7/10] Looking up Ubuntu 24.04 AMI..."
AMI_ID="$(aws ssm get-parameter --region "$AWS_REGION" --name /aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id --query 'Parameter.Value' --output text)"

USER_DATA_FILE="/tmp/${PROJECT}-user-data.sh"
cat > "$USER_DATA_FILE" <<EOF
#!/bin/bash
set -eux
apt-get update -y
apt-get install -y ca-certificates curl unzip docker.io docker-compose-plugin
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

cat > /home/ubuntu/docker-compose.yml <<COMPOSE
services:
  service1:
    image: ${SERVICE1_URI}:latest
    ports:
      - "5000:5000"
    restart: always
  service2:
    image: ${SERVICE2_URI}:latest
    ports:
      - "5001:5001"
    restart: always
COMPOSE

chown ubuntu:ubuntu /home/ubuntu/docker-compose.yml
sudo -u ubuntu docker compose -f /home/ubuntu/docker-compose.yml pull
sudo -u ubuntu docker compose -f /home/ubuntu/docker-compose.yml up -d
EOF

echo "[8/10] Launching two EC2 instances..."
INSTANCE_IDS=( $(aws ec2 run-instances \
  --region "$AWS_REGION" \
  --image-id "$AMI_ID" \
  --instance-type "$INSTANCE_TYPE" \
  --count 2 \
  --key-name "$KEY_NAME" \
  --security-group-ids "$EC2_SG_ID" \
  --subnet-id "${SUBNET_IDS[0]}" \
  --iam-instance-profile Arn="$PROFILE_ARN" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${PROJECT}-ec2}]" \
  --user-data "file://${USER_DATA_FILE}" \
  --query 'Instances[].InstanceId' --output text) )

aws ec2 wait instance-running --region "$AWS_REGION" --instance-ids "${INSTANCE_IDS[@]}"
INSTANCE1="${INSTANCE_IDS[0]}"
INSTANCE2="${INSTANCE_IDS[1]}"

PUB1="$(aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE1" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)"
PUB2="$(aws ec2 describe-instances --region "$AWS_REGION" --instance-ids "$INSTANCE2" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)"

echo "[9/10] Creating target groups and ALB..."
TG1_ARN="$(aws elbv2 describe-target-groups --region "$AWS_REGION" --names "$TG1_NAME" --query 'TargetGroups[0].TargetGroupArn' --output text 2>/dev/null || true)"
if [[ -z "$TG1_ARN" || "$TG1_ARN" == "None" ]]; then
  TG1_ARN="$(aws elbv2 create-target-group --region "$AWS_REGION" --name "$TG1_NAME" --protocol HTTP --port 5000 --vpc-id "$VPC_ID" --health-check-path /health --target-type instance --query 'TargetGroups[0].TargetGroupArn' --output text)"
fi
TG2_ARN="$(aws elbv2 describe-target-groups --region "$AWS_REGION" --names "$TG2_NAME" --query 'TargetGroups[0].TargetGroupArn' --output text 2>/dev/null || true)"
if [[ -z "$TG2_ARN" || "$TG2_ARN" == "None" ]]; then
  TG2_ARN="$(aws elbv2 create-target-group --region "$AWS_REGION" --name "$TG2_NAME" --protocol HTTP --port 5001 --vpc-id "$VPC_ID" --health-check-path /health --target-type instance --query 'TargetGroups[0].TargetGroupArn' --output text)"
fi

aws elbv2 register-targets --region "$AWS_REGION" --target-group-arn "$TG1_ARN" --targets Id="$INSTANCE1",Port=5000 Id="$INSTANCE2",Port=5000
aws elbv2 register-targets --region "$AWS_REGION" --target-group-arn "$TG2_ARN" --targets Id="$INSTANCE1",Port=5001 Id="$INSTANCE2",Port=5001

ALB_ARN="$(aws elbv2 describe-load-balancers --region "$AWS_REGION" --names "$ALB_NAME" --query 'LoadBalancers[0].LoadBalancerArn' --output text 2>/dev/null || true)"
if [[ -z "$ALB_ARN" || "$ALB_ARN" == "None" ]]; then
  ALB_ARN="$(aws elbv2 create-load-balancer --region "$AWS_REGION" --name "$ALB_NAME" --type application --scheme internet-facing --subnets "${SUBNET_IDS[0]}" "${SUBNET_IDS[1]}" --security-groups "$ALB_SG_ID" --query 'LoadBalancers[0].LoadBalancerArn' --output text)"
fi

LISTENER_ARN="$(aws elbv2 describe-listeners --region "$AWS_REGION" --load-balancer-arn "$ALB_ARN" --query 'Listeners[?Port==`80`][0].ListenerArn' --output text)"
if [[ -z "$LISTENER_ARN" || "$LISTENER_ARN" == "None" ]]; then
  LISTENER_ARN="$(aws elbv2 create-listener --region "$AWS_REGION" --load-balancer-arn "$ALB_ARN" --protocol HTTP --port 80 --default-actions Type=fixed-response,FixedResponseConfig='{StatusCode=404,ContentType=text/plain,MessageBody=NotFound}' --query 'Listeners[0].ListenerArn' --output text)"
fi

aws elbv2 create-rule --region "$AWS_REGION" --listener-arn "$LISTENER_ARN" --priority 10 --conditions Field=path-pattern,Values='/service1*' --actions Type=forward,TargetGroupArn="$TG1_ARN" >/dev/null 2>&1 || true
aws elbv2 create-rule --region "$AWS_REGION" --listener-arn "$LISTENER_ARN" --priority 20 --conditions Field=path-pattern,Values='/service2*' --actions Type=forward,TargetGroupArn="$TG2_ARN" >/dev/null 2>&1 || true

aws elbv2 wait target-in-service --region "$AWS_REGION" --target-group-arn "$TG1_ARN" --targets Id="$INSTANCE1" Id="$INSTANCE2"
aws elbv2 wait target-in-service --region "$AWS_REGION" --target-group-arn "$TG2_ARN" --targets Id="$INSTANCE1" Id="$INSTANCE2"

ALB_DNS="$(aws elbv2 describe-load-balancers --region "$AWS_REGION" --load-balancer-arns "$ALB_ARN" --query 'LoadBalancers[0].DNSName' --output text)"

echo "[10/10] Done"
echo "=========================================="
echo "ALB_DNS=${ALB_DNS}"
echo "INSTANCE_1_PUBLIC_IP=${PUB1}"
echo "INSTANCE_2_PUBLIC_IP=${PUB2}"
echo "SERVICE1_ECR=${SERVICE1_URI}:latest"
echo "SERVICE2_ECR=${SERVICE2_URI}:latest"
echo "SSH: ssh -i ~/.ssh/${KEY_NAME}.pem ubuntu@${PUB1}"
echo "SSH: ssh -i ~/.ssh/${KEY_NAME}.pem ubuntu@${PUB2}"
echo "=========================================="
