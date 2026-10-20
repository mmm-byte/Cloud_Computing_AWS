# Module 1: Introduction and AWS IAM

**Lab:** [Lab 1: Identity and Access Management](../../labs/lab-01-iam/)

## What this module covers
- What cloud computing is: the NIST definition (essential characteristics, service models, deployment models) and how private and public clouds differ.
- A first look at the AWS global infrastructure (Regions and Availability Zones) and the shared responsibility model.
- **AWS IAM:** who can do what in an AWS account.

## Key concepts
| Concept | One-line summary |
|---|---|
| Root user | Owns the account; lock it down and avoid daily use |
| IAM user / group / role | Identities; groups bundle users, roles are assumed temporarily |
| Policy | JSON document that allows or denies actions on resources |
| Least privilege | Grant only the permissions a task needs |
| MFA | Second factor for sign-in, essential for the root user |
| Access keys | Programmatic credentials for the CLI/SDK; rotate and never commit them |

## Hands-on (Lab 1)
Locked down the root user, created an admin IAM user, attached managed policies (for example S3 access), created and then deleted an access key, and used an IAM group to grant and remove permissions.

## Course materials
- Slides: Introduction, AWS Overview, AWS IAM, NIST SP 800-145
- Discussion: Private cloud vs. public cloud
- Research and report: Cloud computing history
- Quiz: IAM
