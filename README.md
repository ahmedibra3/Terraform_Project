# 🚀 Terraform AWS Infrastructure Project

![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.3.0-blue)
![AWS Provider](https://img.shields.io/badge/AWS-Provider-FF9900)
![License](https://img.shields.io/badge/license-MIT-green)


## 🌟 Project Overview
This Terraform project deploys a highly available infrastructure on AWS with:
- 2 Proxy servers in public subnets
- 2 Apache servers in private subnets 
- Public and private Application Load Balancers
- Secure network configuration

## 📊 Architecture
![AWS Infrastructure Diagram](docs/images/architecture.png)

## 🛠️ Prerequisites
- Terraform >= 1.3.0
- AWS account with IAM permissions
- AWS CLI configured
- SSH key pair


### 1. Clone the repository
```bash
git clone https://github.com/ahmedibra3/Terraform_Project.git
cd Terraform_Project
