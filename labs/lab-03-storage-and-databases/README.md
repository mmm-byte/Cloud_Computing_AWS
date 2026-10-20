# Lab 3: Storage and Database Services

| | |
|---|---|
| **Module** | [Module 3: Cloud Data Storage](../../modules/03-storage-and-databases/) |
| **Services** | S3, RDS, DynamoDB |
| **Proof of work** | [lab-03-storage-and-databases.pdf](proof/lab-03-storage-and-databases.pdf) (25 pages, redacted) |

## Objective
Store and serve data with S3, then provision managed relational and NoSQL databases.

## Exercises completed

### Amazon S3

| Exercise | Task | What it demonstrates |
|---|---|---|
| 3.1 | Create a bucket and upload a file | Basic bucket creation and object upload |
| 3.2 | Enable versioning and lifecycle management | Protecting against overwrites and moving data to cheaper storage over time |
| 3.3 | Generate and use a presigned URL | Granting time-limited access to a private object |
| 3.4 | Enable static website hosting | Serving a website directly from a bucket |
| 3.5 | Calculate total lifecycle costs | Comparing storage classes against access patterns |

### Databases

| Exercise | Task | What it demonstrates |
|---|---|---|
| 5.1 | Create an RDS instance | Launched a managed MariaDB instance from the Free tier template |
| 5.2 | Create a read replica | Offloading read traffic from the primary database |
| 5.3 | Promote the read replica to a primary | The failover and migration path for replicas |
| 5.4 | Create a DynamoDB table in provisioned mode | Defining a NoSQL table and its read and write capacity |

## Key points
- Versioning plus lifecycle rules give durability and cost control with no application changes.
- Presigned URLs share a private object without making the bucket public.
- A read replica scales reads and can be promoted to a standalone database.
- Relational databases suit structured data and joins. DynamoDB suits key-based access at large scale.

## Related
Module guide: [Storage and Databases](../../modules/03-storage-and-databases/). S3 replication and Transfer Acceleration continue in [Lab 8](../lab-08-high-performing-architectures/).
