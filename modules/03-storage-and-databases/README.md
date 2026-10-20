# Module 3: Cloud Data Storage (S3 and Database Services)

**Lab:** [Lab 3: Storage and Database Services](../../labs/lab-03-storage-and-databases/)

## What this module covers
- Cloud storage models: object, block and file.
- **S3:** buckets and objects, storage classes, versioning, lifecycle rules, access control.
- Managed databases: relational (RDS) and NoSQL (DynamoDB), and when to choose each.

## Key concepts
| Concept | One-line summary |
|---|---|
| S3 bucket / object | Flat, key-based object storage with very high durability |
| Storage class | Cost/latency trade-off (for example Standard vs. archive tiers) |
| Versioning and lifecycle | Keep prior versions; move or expire objects automatically |
| RDS | Managed relational databases (backups, patching, Multi-AZ) |
| DynamoDB | Managed key-value / document NoSQL store |
| Relational vs. NoSQL | Strong schema and joins vs. flexible schema and horizontal scale |

## Hands-on (Lab 3)
Created an S3 bucket and uploaded files, enabled versioning and lifecycle rules, generated a presigned URL, hosted a static website from S3, and calculated lifecycle costs (Exercises 3.1 to 3.5). Created an RDS instance, a read replica and promoted it to a primary, and created a DynamoDB table in provisioned mode (Exercises 5.1 to 5.4).

## Course materials
- Slides: Cloud Storage, S3, Databases
- Discussion: NoSQL
- Research and report: IBM Cloud and Oracle Cloud
- Quiz: Cloud storage, EFS and database services
