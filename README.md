# Azure Network Infrastructure with Terraform

This project deploys foundational Azure networking infrastructure using Terraform.

## Resources

- Azure Resource Group
- Virtual Network: `10.10.0.0/16`
- Subnet: `10.10.1.0/24`

## Project Structure

- `main.tf` — Azure provider and resource definitions
- `variables.tf` — Input variable definitions
- `outputs.tf` — Resource information displayed after deployment
- `.terraform.lock.hcl` — Locked provider versions
- `.gitignore` — Excludes local and sensitive Terraform files

## Usage

```bash
az login
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
