# Terraform VPC and EC2 Examples

This repository contains various Terraform examples demonstrating different patterns and best practices for AWS infrastructure deployment. Examples are numbered for a progressive learning path.

## Directory Structure

| Directory | Description |
|-----------|-------------|
| [01-basic-vpc-ec2/](01-basic-vpc-ec2/) | Basic VPC with EC2 instance deployment |
| [02-ec2-for-each/](02-ec2-for-each/) | Multiple EC2 instances using `for_each` |
| [03-conditional-ami/](03-conditional-ami/) | Conditional resource creation with data sources |
| [04-dynamic-blocks/](04-dynamic-blocks/) | Dynamic blocks and count-based scaling |
| [05-provisioners-ecr/](05-provisioners-ecr/) | ECR with local-exec provisioners |
| [06-remote-state/](06-remote-state/) | S3 backend with DynamoDB state locking |
| [07-module-outputs/](07-module-outputs/) | Module outputs and resource tagging |
| [08-terragrunt-multi-env/](08-terragrunt-multi-env/) | Multi-environment deployments with Terragrunt |

## Examples Overview

### 01-basic-vpc-ec2
Creates a complete VPC setup with:
- VPC with DNS support
- Subnet and Internet Gateway
- Security Group
- EC2 instance with configurable OS (Linux/Windows)

### 02-ec2-for-each
Demonstrates using `for_each` to create multiple EC2 instances without code duplication.

### 03-conditional-ami
Shows conditional AMI selection using:
- Data sources to fetch latest Ubuntu AMI
- Ternary expressions for conditional logic

### 04-dynamic-blocks
Demonstrates advanced patterns:
- `count` meta-argument for scaling
- `dynamic` blocks for EBS volumes
- Conditional Elastic IP creation

### 05-provisioners-ecr
Example of `local-exec` provisioners with ECR:
- Destroy-time provisioner to backup images
- Image push automation
- **Note**: Provisioners should be used as a last resort

### 06-remote-state
Remote state management with:
- S3 backend configuration
- DynamoDB table for state locking
- Encryption enabled

### 07-module-outputs
Module output usage:
- Custom module with outputs
- Using outputs for additional resource configuration
- `aws_ec2_tag` resource for dynamic tagging

### 08-terragrunt-multi-env
Multi-environment setup:
- Root configuration for shared settings
- Environment-specific configurations (dev/qa/prod)
- DRY (Don't Repeat Yourself) patterns

## Requirements

- Terraform >= 1.0.0
- AWS Provider ~> 5.0
- AWS credentials configured
- Terragrunt (for terragrunt examples)

## Usage

```bash
cd <example-directory>
terraform init
terraform plan
terraform apply
```

For Terragrunt examples:
```bash
cd 08-terragrunt-multi-env/<environment>
terragrunt init
terragrunt plan
terragrunt apply
```