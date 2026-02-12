# Terraform & Ansible Multi-Instance Nginx

## Project Overview
This project provisions **two EC2 instances** on AWS using Terraform and configures them using Ansible with a reusable role.  
Each instance runs Nginx and serves a custom HTML page identifying the server.

Instances:
- web01
- web02

## Architecture
- Terraform:
  - Creates 2 EC2 instances using `for_each` or `count`
  - Creates 1 Security Group (SSH + HTTP)
  - Outputs list of public IPs and DNS
- Ansible:
  - Uses a reusable `nginx` role
  - Installs and enables Nginx
  - Deploys a Jinja2 template
  - Configures both servers in one run

```

[Browser] --> [web01 | web02 (Nginx)]
Provisioned by Terraform
Configured by Ansible Role

````

## Prerequisites
- AWS account
- Terraform installed
- Ansible installed
- SSH key pair configured
- Browser for testing

## How to Run Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
````

Terraform outputs:

* List of public IPs
* List of public DNS names

## How to Run Ansible

Update inventory with the generated IPs.

```bash
cd ansible
ansible-playbook -i inventory/hosts.yml playbooks/site.yml
```

## Expected Result

Visiting each instance IP:

```
http://<web01-ip>
→ Hello from web01

http://<web02-ip>
→ Hello from web02
```

## Cleanup

```bash
cd terraform
terraform destroy
```

## Key Concepts Demonstrated

* Terraform loops (`for_each` / `count`)
* Handling list outputs
* Ansible roles (enterprise structure)
* Jinja2 templating
* Multi-host configuration
* Idempotent automation


