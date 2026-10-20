# Module 4: Cloud Networks (VPC, Route 53, CloudFront)

**Lab:** [Lab 4: VPC, Route 53 and CloudFront](../../labs/lab-04-vpc-route53-cloudfront/)

## What this module covers
- **VPC:** your own isolated network in AWS: CIDR blocks, subnets, route tables, gateways.
- **Route 53:** DNS and routing policies.
- **CloudFront:** the content delivery network that caches content at edge locations.
- IPv4 vs. IPv6 (research topic).

## Key concepts
| Concept | One-line summary |
|---|---|
| CIDR block | Address range of the VPC and its subnets (for example `172.16.0.0/16`) |
| Public vs. private subnet | Whether the route table has a route to an internet gateway |
| Internet gateway / NAT | Inbound/outbound internet access for subnets |
| Security group vs. network ACL | Stateful instance-level firewall vs. stateless subnet-level rules |
| Elastic IP | Static public IPv4 address |
| Transit gateway | Hub that connects multiple VPCs |
| Route 53 | Managed DNS with health checks and routing policies |
| CloudFront | CDN that lowers latency and offloads the origin |

## Hands-on (Lab 4)
Built networking from the AWS CLI: a VPC, subnet, primary network interface, internet gateway and default route, a custom security group with an inbound rule, an Elastic IP, a transit gateway and a blackhole route (Exercises 4.1 to 4.9). Then created a Route 53 hosted zone, a health check and a failover routing policy, and put a CloudFront distribution in front of an S3 static website (Exercises 8.1 to 8.4).

## Course materials
- Slides: Cloud Networks, VPC, Route 53, CloudFront
- Research and report: IPv4 and IPv6
- Quiz: VPC, Route 53 and CloudFront
