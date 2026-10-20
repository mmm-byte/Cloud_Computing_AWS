# Module 5: Resource Management and Scheduling (ELB and Auto Scaling)

**Lab:** [Lab 5: EC2 Auto Scaling](../../labs/lab-05-ec2-auto-scaling/)

## What this module covers
- How clouds allocate and schedule resources, and the cost of over-provisioning.
- **Elastic Load Balancing:** spreading traffic across healthy targets.
- **EC2 Auto Scaling:** adding and removing instances automatically.

## Key concepts
| Concept | One-line summary |
|---|---|
| Application Load Balancer | Layer 7 load balancer with host/path routing |
| Target group and health check | The set of targets a load balancer routes to, and how it decides they are healthy |
| Launch template | Blueprint for the instances an Auto Scaling group creates |
| Auto Scaling group | Keeps min/desired/max instances running across Availability Zones |
| Scaling policy | Rule such as "add capacity when average CPU > 40%" |
| Horizontal vs. vertical scaling | More instances vs. a bigger instance |

## Hands-on
- [Lab 5](../../labs/lab-05-ec2-auto-scaling/): created a launch template whose user data installs a web server, launched an instance from it and verified the page (Exercise 10.1).
- [Lab 8](../../labs/lab-08-high-performing-architectures/), Exercise 11.1: configured and launched an application using Auto Scaling.
- Applied in the capstone-style project: [DevOps assessment](../../projects/devops-assessment/), which puts two EC2 instances behind an ALB with path-based routing. The Auto Scaling bonus there is not built yet.

## Course materials
- Slides: Cloud Resource Management, AWS Auto Scaling, AWS ELB
- Discussion: Over-provisioning
- Research and report: Auto-scaling containerized cloud applications
