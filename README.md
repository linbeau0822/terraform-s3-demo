# Terraform Demo with AWS S3 and CloudFront

## Overview
This project is part of my journey learning Terraform. It demonstrates Infrastructure as Code by provisioning AWS resources—specifically S3 buckets and CloudFront distributions—to host a simple webpage. The setup simulates development, QA, and production environments, and incorporates CI/CD pipelines using GitHub Actions to automate deployments and environment promotions. This project highlights environment isolation, automated provisioning, and a workflow for safely promoting changes across environments.

![Sequence diagram](image.png)

## CloudFront Distributions
**dev:** https://do3wrs8fapq5e.cloudfront.net

**qa:** https://d2z1dwdrnegcbn.cloudfront.net

**prod:** https://d1vrl10xp6tnjy.cloudfront.net

## Commands
Upload a file to an S3 bucket
```sh
aws s3 cp index.html s3://myBucket
```

Terraform commands
```sh
terraform fmt # lints terraform code
terraform validate # validates terraform code
terraform plan # see the changes that will be made (doesn't execute anything)
terraform apply # apply terraform changes
```
