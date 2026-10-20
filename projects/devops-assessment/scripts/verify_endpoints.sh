#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="${AWS_REGION:-us-east-1}"
ALB_DNS="${ALB_DNS:?Set ALB_DNS}"

echo "Checking /service1"
R1="$(curl -fsS "http://${ALB_DNS}/service1")"
echo "$R1"

echo "Checking /service2"
R2="$(curl -fsS "http://${ALB_DNS}/service2")"
echo "$R2"

echo "Checking ECR repositories"
S1_REPO="$(aws ecr describe-repositories --region "$AWS_REGION" --repository-names service1 --query 'repositories[0].repositoryUri' --output text)"
S2_REPO="$(aws ecr describe-repositories --region "$AWS_REGION" --repository-names service2 --query 'repositories[0].repositoryUri' --output text)"
echo "service1 repo: ${S1_REPO}"
echo "service2 repo: ${S2_REPO}"

echo "All checks passed."
