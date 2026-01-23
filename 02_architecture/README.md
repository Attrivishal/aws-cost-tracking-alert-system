----------------------------------------------------
# System Architecture

This project follows a production-style cloud architecture that separates
compute, monitoring, storage, identity, and alerting into clear layers.

The design focuses on:
- Security isolation
- Stateless compute
- Centralized monitoring
- Least-privilege access
- Cost awareness
- Failure visibility

The goal is not complexity — the goal is clarity and reliability.

---

## High-Level Architecture Flow

User / Admin  
↓  
Secure Access (SSH / IAM Role)  
↓  
EC2 Instance (Linux Server)  
↓  
Monitoring Layer (CloudWatch Metrics & Logs)  
↓  
Alerting Layer (CloudWatch Alarms → SNS Email Alerts)  
↓  
Storage Layer (S3 for data & backups)

---

##  Architecture Layers

### 1. Access Layer
- SSH access to EC2 using key-based authentication
- IAM Role attached to EC2
- No hardcoded AWS credentials inside the server

Purpose:
Secure access and identity-based trust instead of static secrets.

---

### 2. Compute Layer (EC2 + Linux)

- Ubuntu EC2 instance
- Linux used for:
  - system monitoring
  - scripting
  - automation
  - networking checks
  - log inspection
  - service management

EC2 is treated as **replaceable infrastructure**, not a data storage layer.

---

### 3. Monitoring Layer (CloudWatch)

CloudWatch collects:
- CPU utilization
- system health
- instance metrics
- service behavior

This creates **visibility** into system state instead of blind operation.

---

### 4. Alerting Layer (CloudWatch Alarms + SNS)

CloudWatch Alarms:
- trigger on CPU spikes
- trigger on abnormal behavior
- trigger on thresholds

SNS:
- sends real-time alerts to email
- converts system signals into human notifications

This creates **early warning systems** instead of late failure detection.

---

### 5. Storage Layer (Amazon S3)

S3 is used for:
- persistent data storage
- backups
- file storage
- shared access

Data is not tied to EC2 lifecycle.

This prevents data loss when instances are stopped, terminated, or replaced.

---

## Security Design

Security is implemented in layers:

- IAM Roles instead of access keys
- Security Groups instead of open ports
- Private server access model
- Controlled inbound rules
- No public write access to S3
- Least-privilege permissions

Security is **architectural**, not reactive.

---

##  Data Flow Model

Linux EC2 system generates:
- system metrics
- service metrics
- operational signals

These flow to:
CloudWatch → Alarm → SNS → Email Alert

This creates:
**System → Signal → Detection → Alert → Human Response**

---

##  Cost-Aware Design

This architecture is designed to stay Free Tier safe:
- Single EC2 instance
- No NAT Gateway
- No paid monitoring tools
- No external SaaS services
- No multi-AZ paid services
- Native AWS services only

This allows real learning without financial risk.

---

##  Engineering Principle Used

- Observability over guessing
- Automation over manual checks
- Monitoring over assumptions
- Architecture over scripts
- Design before tools
- Security by default
- Cost awareness by design
