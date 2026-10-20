# Lab 1: Identity and Access Management

| | |
|---|---|
| **Module** | [Module 1: Introduction and AWS IAM](../../modules/01-iam/) |
| **Services** | IAM, S3, AWS CLI |
| **Proof of work** | [lab-01-iam.pdf](proof/lab-01-iam.pdf) (15 pages, redacted) |

## Objective
Secure a new AWS account and practice the core IAM workflow: protect the root user, create users with scoped permissions, manage programmatic credentials, and organize permissions with groups.

## Exercises completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 6.1 | Lock down the root user | Created an administrator IAM user for daily work, confirmed the root user has no access keys, enabled MFA on root, and set a strong root password |
| 6.2 | Assign an IAM policy to a user | Created an IAM user, attached the `AmazonS3FullAccess` managed policy, and used it to manage S3 buckets |
| 6.3 | Create, use and delete an access key | Generated an access key, configured the AWS CLI with `aws configure`, then deactivated the key |
| 6.4 | Create and configure an IAM group | Created a group with the `IAMUserChangePassword` policy, added two users, and tested the permission before removing it |

## Key points
- The root user should be used only for tasks that require it. Day-to-day work belongs to IAM users or roles.
- MFA on the root user is the single most valuable control on a new account.
- Access keys are long-lived credentials. Create them only when needed, never share or commit them, and deactivate or delete them when finished.
- Groups make permissions easier to audit than attaching policies to individual users.
- Managed policies such as `AmazonS3FullAccess` are quick to apply, but custom policies grant least privilege more precisely.

## Related
Module guide: [AWS IAM](../../modules/01-iam/). IAM is applied again in [Lab 7](../lab-07-secure-architectures/) with permissions boundaries and role assumption.
