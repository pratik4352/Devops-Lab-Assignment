# Assignment 5: Cloud Infrastructure and Server Automation Using AWS and Ansible

This directory contains the Ansible playbooks, configuration manifests, dynamic Jinja2 templates, and laboratory documentation for **Assignment 5: Cloud Infrastructure and Server Automation Using AWS and Ansible**.

---

## Automation Manifests in this Directory

- [`ansible.cfg`](./ansible.cfg): Custom Ansible configuration setting default inventory, remote user (`ubuntu`), privilege escalation, and SSH options.
- [`inventory.ini.example`](./inventory.ini.example): Template host inventory declaring managed EC2 instances and Python interpreter paths.
- [`playbook.yml`](./playbook.yml): Complete playbook for updating apt cache, installing Nginx, starting/enabling services, deploying custom Jinja2 templates, and verifying HTTP connectivity.
- [`update_webpage.yml`](./update_webpage.yml): Secondary playbook demonstrating version updates and idempotency verification.
- [`templates/index.html.j2`](./templates/index.html.j2): Dynamic HTML5 web template rendering Ansible system facts (hostname, IP address, OS release, deployment timestamp).
- [`ASSIGNMENT_5_REPORT.md`](./ASSIGNMENT_5_REPORT.md): Complete laboratory submission report with AWS services definitions, Ansible components, execution logs, and best practices.

---

## How to Execute the Automation

### 1. Configure the Target Inventory
Copy the example inventory and replace the placeholder IP with your actual AWS EC2 Public IPv4 address:
```bash
cp inventory.ini.example inventory.ini
nano inventory.ini
```

Ensure your EC2 private key permissions are secure:
```bash
chmod 400 ~/.ssh/devops-ec2-key.pem
```

### 2. Verify Connectivity (Ad-Hoc Ping)
```bash
ansible -i inventory.ini webservers -m ping
```

### 3. Execute the Provisioning Playbook
```bash
ansible-playbook playbook.yml
```

### 4. Verify Web Server Accessibility
Access the public IP in your browser or run:
```bash
curl http://<EC2_PUBLIC_IP>
```

### 5. Deploy Updated Version (Idempotency Check)
```bash
ansible-playbook update_webpage.yml
```
