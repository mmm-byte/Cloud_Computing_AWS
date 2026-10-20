# Lab 4: VPC, Route 53 and CloudFront

| | |
|---|---|
| **Module** | [Module 4: Cloud Networks](../../modules/04-networking-vpc-route53-cloudfront/) |
| **Services** | VPC, subnets, ENI, internet gateway, security groups, network ACLs, Elastic IP, transit gateway, Route 53, CloudFront |
| **Proof of work** | [lab-04-vpc-route53-cloudfront.pdf](proof/lab-04-vpc-route53-cloudfront.pdf) (49 pages, redacted) |

## Objective
Build a network from the command line, connect two VPCs through a transit gateway, then add DNS and content delivery with Route 53 and CloudFront.

## Exercises completed

### VPC and connectivity (AWS CLI)

| Exercise | Task | Detail |
|---|---|---|
| 4.1 | Create a VPC | Primary CIDR `172.16.0.0/16` |
| 4.2 | Create a subnet | `172.16.100.0/24` in `us-east-1a` |
| 4.3 | Create and attach a primary network interface | Fixed private IP `172.16.100.99` |
| 4.4 | Create an internet gateway and default route | Route `0.0.0.0/0` to the gateway |
| 4.5 | Create a custom security group | Group `web-ssh` |
| 4.6 | Add inbound rules | SSH (22), HTTP (80) and HTTPS (443), plus network ACL entries |
| 4.7 | Allocate and associate an Elastic IP | Static public address on the network interface |
| 4.8 | Create a transit gateway | Second VPC `172.17.0.0/16` with subnet `172.17.100.0/24` in `us-east-1b`, both VPCs attached, routes added in both directions |
| 4.9 | Create a blackhole route | Dropped traffic to `172.16.100.64/29`, then deleted the attachments and gateway |

### DNS and content delivery (console)

| Exercise | Task | What it demonstrates |
|---|---|---|
| 8.1 | Create a Route 53 hosted zone for an EC2 web server | Public DNS for a web server |
| 8.2 | Set up a health check | Monitoring an endpoint over HTTP |
| 8.3 | Configure a failover routing policy | Primary and secondary records tied to health checks |
| 8.4 | Create a CloudFront distribution for an S3 static website | Caching content at edge locations |

## Commands used
Resource IDs are replaced with placeholders.

```bash
# VPC, subnet and network interface
aws ec2 create-vpc --cidr-block 172.16.0.0/16
aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 172.16.100.0/24 --availability-zone us-east-1a
aws ec2 create-network-interface --private-ip-address 172.16.100.99 --subnet-id <subnet-id>

# Internet access
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id <igw-id> --vpc-id <vpc-id>
aws ec2 create-route --route-table-id <rtb-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <igw-id>

# Security group and network ACL
aws ec2 create-security-group --group-name web-ssh --description "Web and SSH traffic" --vpc-id <vpc-id>
aws ec2 authorize-security-group-ingress --group-id <sg-id> --protocol tcp --cidr 0.0.0.0/0 --port 22
aws ec2 create-network-acl --vpc-id <vpc-id>

# Elastic IP
aws ec2 allocate-address
aws ec2 associate-address --allocation-id <eipalloc-id> --network-interface-id <eni-id>

# Transit gateway between two VPCs
aws ec2 create-transit-gateway
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id <tgw-id> --vpc-id <vpc-id> --subnet-ids <subnet-id>
aws ec2 create-route --route-table-id <rtb-id> --destination-cidr-block 172.17.0.0/16 --transit-gateway-id <tgw-id>
aws ec2 create-transit-gateway-route --destination-cidr-block 172.16.100.64/29 --transit-gateway-route-table-id <tgw-rtb-id> --blackhole
```

## Key points
- A subnet is public only because its route table sends `0.0.0.0/0` to an internet gateway.
- Security groups are stateful and attach to interfaces. Network ACLs are stateless, ordered by rule number, and apply to subnets.
- A transit gateway connects VPCs through a hub, so each VPC needs only one attachment instead of a peering link to every other VPC.
- A blackhole route silently drops traffic to a prefix, which is useful for isolating a range.
- Failover routing needs a health check on the primary record, otherwise Route 53 has no signal to switch.

## Notes
- The lab opens SSH, HTTP and HTTPS to `0.0.0.0/0` for testing. In real environments, restrict SSH to a known source address.
- Transit gateway attachments are billed hourly. They were deleted at the end of Exercise 4.9.

## Related
Module guide: [Networking](../../modules/04-networking-vpc-route53-cloudfront/). The same security group and routing ideas appear in the [DevOps project](../../projects/devops-assessment/).
