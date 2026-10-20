# Module 8: Serverless Computing (AWS Lambda)

**Lab:** [Lab 8: High-Performing Architectures](../../labs/lab-08-high-performing-architectures/)

## What this module covers
- The serverless model: run code without managing servers.
- **AWS Lambda:** event-driven functions, triggers, scaling and pay-per-use pricing.
- Designing resilient and high-performing architectures, and learning from cloud system failures (research topic).

## Key concepts
| Concept | One-line summary |
|---|---|
| Function | Unit of code Lambda runs in response to an event |
| Trigger | Event source such as S3, API Gateway or SQS |
| Concurrency and cold start | How Lambda scales, and the latency of a new execution environment |
| Resilience | Multi-AZ design, retries and decoupling |

## Hands-on (Lab 8)
The lab for this module covers high-performing architectures rather than Lambda itself: an application behind Auto Scaling (11.1), cross-region replication between two S3 buckets (11.2), S3 Transfer Acceleration (11.3), a CloudFormation nested stack (11.5) and a CloudWatch dashboard (11.6). Lambda is covered in the course slides but is not exercised in a lab here.

## Course materials
- Slides: AWS Serverless
- Research and report: Cloud system failures
- Quiz: Resilient architectures
