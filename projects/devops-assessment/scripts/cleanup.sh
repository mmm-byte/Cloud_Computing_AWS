#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-us-east-1}"
PROJECT="${PROJECT:-interview-ms}"

ALB_NAME="${PROJECT}-alb"
TG1_NAME="${PROJECT}-tg-s1"
TG2_NAME="${PROJECT}-tg-s2"
ALB_SG_NAME="${PROJECT}-alb-sg"
EC2_SG_NAME="${PROJECT}-ec2-sg"
ROLE_NAME="${PROJECT}-ec2-ecr-role"
PROFILE_NAME="${PROJECT}-ec2-profile"

echo "Terminating project EC2 instances..."
INSTANCE_IDS=$(aws ec2 describe-instances --region "$AWS_REGION" \
  --filters Name=tag:Name,Values="${PROJECT}-ec2" Name=instance-state-name,Values=pending,running,stopping,stopped \
  --query 'Reservations[].Instances[].InstanceId' --output text || true)
if [[ -n "$INSTANCE_IDS" ]]; then
  aws ec2 terminate-instances --region "$AWS_REGION" --instance-ids $INSTANCE_IDS >/dev/null || true
  aws ec2 wait instance-terminated --region "$AWS_REGION" --instance-ids $INSTANCE_IDS || true
fi

ALB_ARN=$(aws elbv2 describe-load-balancers --region "$AWS_REGION" --names "$ALB_NAME" --query 'LoadBalancers[0].LoadBalancerArn' --output text 2>/dev/null || true)
if [[ -n "$ALB_ARN" && "$ALB_ARN" != "None" ]]; then
  aws elbv2 delete-load-balancer --region "$AWS_REGION" --load-balancer-arn "$ALB_ARN" || true
  sleep 15
fi

TG1_ARN=$(aws elbv2 describe-target-groups --region "$AWS_REGION" --names "$TG1_NAME" --query 'TargetGroups[0].TargetGroupArn' --output text 2>/dev/null || true)
TG2_ARN=$(aws elbv2 describe-target-groups --region "$AWS_REGION" --names "$TG2_NAME" --query 'TargetGroups[0].TargetGroupArn' --output text 2>/dev/null || true)
[[ -n "$TG1_ARN" && "$TG1_ARN" != "None" ]] && aws elbv2 delete-target-group --region "$AWS_REGION" --target-group-arn "$TG1_ARN" || true
[[ -n "$TG2_ARN" && "$TG2_ARN" != "None" ]] && aws elbv2 delete-target-group --region "$AWS_REGION" --target-group-arn "$TG2_ARN" || true

for SG_NAME in "$EC2_SG_NAME" "$ALB_SG_NAME"; do
  SG_ID=$(aws ec2 describe-security-groups --region "$AWS_REGION" --filters Name=group-name,Values="$SG_NAME" --query 'SecurityGroups[0].GroupId' --output text 2>/dev/null || true)
  [[ -n "$SG_ID" && "$SG_ID" != "None" ]] && aws ec2 delete-security-group --region "$AWS_REGION" --group-id "$SG_ID" || true
done

aws iam remove-role-from-instance-profile --instance-profile-name "$PROFILE_NAME" --role-name "$ROLE_NAME" >/dev/null 2>&1 || true
aws iam delete-instance-profile --instance-profile-name "$PROFILE_NAME" >/dev/null 2>&1 || true
aws iam detach-role-policy --role-name "$ROLE_NAME" --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly >/dev/null 2>&1 || true
aws iam delete-role --role-name "$ROLE_NAME" >/dev/null 2>&1 || true

echo "Cleanup attempted. Verify in AWS Console for safety."
