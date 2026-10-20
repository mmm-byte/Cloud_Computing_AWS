# Module 6: Cloud Applications (CloudWatch, SNS and SQS)

**Lab:** [Lab 6: CloudTrail, CloudWatch and Config](../../labs/lab-06-cloudtrail-cloudwatch-config/)

## What this module covers
- **Observability:** metrics, logs and alarms with CloudWatch.
- **Auditing and compliance:** API activity with CloudTrail and resource configuration history with AWS Config.
- **Decoupling:** SNS (publish/subscribe) and SQS (queues).
- Cloud migration case studies (research topic).

## Key concepts
| Concept | One-line summary |
|---|---|
| CloudWatch metric / alarm | Time-series data and thresholds that trigger actions |
| CloudWatch Logs | Centralized log storage and search |
| CloudTrail | Records who called which AWS API, and when |
| AWS Config | Tracks resource configuration changes and evaluates rules |
| SNS | Fan-out notifications to many subscribers |
| SQS | Durable queue that decouples producers from consumers |

## Hands-on (Lab 6)
Created a CloudTrail trail for write-only management events (7.1), graphed EC2 NetworkIn and NetworkOut with CloudWatch metric math (7.2), and streamed CloudTrail events to CloudWatch Logs (7.3). AWS Config, SNS and SQS are covered in the course material but not exercised in this lab.

## Course materials
- Slides: Cloud Apps, AWS CloudWatch, Decoupling Workflows
- Discussion: Free cloud access
- Research and report: Cloud migration case studies
- Quiz: Cloud applications
