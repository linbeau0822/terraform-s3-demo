# Terraform Demo with AWS S3 and CloudFront

## Overview
This is a project as part of my 5+ where I learned Terraform. This project utilizes Terraform as Infrastructure as Code, AWS CloudFront and AWS S3 to create CloudFront distributions, displaying the webpage from an S3 bucket. It simulates a dev, qa, and prod environment setup, with CI/CD configured through Github Actions.

![Sequence diagram](image.png)

## CloudFront Distributions
**dev:** `https://do3wrs8fapq5e.cloudfront.net`

**qa:** `https://d2z1dwdrnegcbn.cloudfront.net`

**prod:** `https://d1vrl10xp6tnjy.cloudfront.net`

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
