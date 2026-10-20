# Lab 7: Secure Architectures

| | |
|---|---|
| **Module** | [Module 7: Cloud Security](../../modules/07-cloud-security/) |
| **Services** | IAM, VPC Flow Logs, CloudWatch Logs, EBS |
| **Proof of work** | [lab-07-secure-architectures.pdf](proof/lab-07-secure-architectures.pdf) (31 pages, redacted) |

## Objective
Apply security controls at the identity, network and storage layers.

## Exercises completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 12.1 | Create a limited administrative user | Used a permissions boundary (`LimitedAdminPolicyBoundary`) to cap a user at EC2 actions |
| 12.2 | Create and assume a role as an IAM user | Switched to a role for temporary credentials |
| 12.3 | Configure VPC Flow Logging | Delivered network traffic records to CloudWatch Logs |
| 12.4 | Encrypt an EBS volume | Protected data at rest on block storage |

## Key points
- A permissions boundary sets the maximum permissions a user can ever have, even if broader policies are attached later.
- Roles issue temporary credentials, which are safer than long-lived access keys.
- Flow logs record accepted and rejected traffic and are the starting point for network investigations.
- Encrypting at rest is a setting at creation time. Encrypting an existing unencrypted volume requires copying it.

## Related
Module guide: [Cloud Security](../../modules/07-cloud-security/). Builds on [Lab 1](../lab-01-iam/) for IAM and [Lab 4](../lab-04-vpc-route53-cloudfront/) for VPC networking.
