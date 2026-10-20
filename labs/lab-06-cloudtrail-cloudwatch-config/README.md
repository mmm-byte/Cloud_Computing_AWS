# Lab 6: CloudTrail, CloudWatch and Config

| | |
|---|---|
| **Module** | [Module 6: Cloud Applications](../../modules/06-monitoring-sns-sqs/) |
| **Services** | CloudTrail, CloudWatch Metrics, CloudWatch Logs, IAM, S3 |
| **Proof of work** | [lab-06-cloudtrail-cloudwatch-config.pdf](proof/lab-06-cloudtrail-cloudwatch-config.pdf) (11 pages, redacted) |

## Objective
Record account activity with CloudTrail and observe resource behavior with CloudWatch.

## Exercises completed

| Exercise | Task | What it demonstrates |
|---|---|---|
| 7.1 | Create a trail | Logged write-only management events in all regions to an S3 bucket |
| 7.2 | Graph metrics with metric math | Plotted EC2 `NetworkIn` and `NetworkOut` and added a derived series with the expression `m1+m2` |
| 7.3 | Deliver CloudTrail logs to CloudWatch Logs | Enabled log streaming with an IAM role that lets CloudTrail write to a log group |

## Key points
- CloudTrail answers who did what and when. CloudWatch answers how a resource is performing.
- Logging only write events keeps volume and cost down while still capturing every change.
- Sending trail events to CloudWatch Logs makes them searchable and lets alarms react to them.
- Metric math combines existing metrics without writing code.
- The console now creates the trail's S3 bucket automatically, so the manual bucket step in the exercise was not needed.

## Scope note
AWS Config appears in the lab title but is not part of these three exercises.

## Related
Module guide: [Monitoring, SNS and SQS](../../modules/06-monitoring-sns-sqs/). A CloudWatch dashboard is built in [Lab 8](../lab-08-high-performing-architectures/).
