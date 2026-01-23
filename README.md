AWS Cost Tracking & Alert System

(Cloud + Linux Operations Project)

 Project Overview

This project documents my hands-on experience building a cost-aware monitoring and alerting system on AWS using Linux automation and native AWS services.

Instead of focusing on deploying applications, I focused on cloud operations:

How costs are monitored

How system health is checked

How alerts are triggered and delivered

How failures are detected and debugged

How Linux and AWS work together in real environments

The project was built using AWS Free Tier–friendly services and tested through real failure scenarios.

 Problem Statement

In real cloud environments, teams often face these problems:

Cloud costs increase silently

Disk usage grows until systems fail

CPU or load spikes go unnoticed

Alerts are misconfigured or never delivered

Engineers rely only on dashboards instead of automation

I wanted to build a simple but realistic system that detects such issues early and notifies engineers automatically.

 Solution Approach

I designed a system that combines:

AWS native monitoring (CloudWatch, Budgets)

Event-based alerts (SNS)

Linux automation (Shell scripts)

IAM roles (no access keys on servers)

The system monitors:

AWS cost thresholds

Disk usage on EC2

CPU, memory, and load average

System health in real time

Alerts are sent via email using SNS.

 High-Level Architecture
Linux Scripts (EC2)
   │
   │  (checks system + cost state)
   ▼
AWS Services
   ├─ AWS Budgets (cost limits)
   ├─ CloudWatch (metrics & alarms)
   ├─ SNS (email notifications)
   └─ IAM Role (secure access)

Key Design Decisions

EC2 instances do not store credentials

IAM roles are attached directly to EC2

Linux scripts trigger alerts based on real conditions

AWS handles alert delivery and reliability

 Technologies Used
AWS

Amazon EC2

IAM (Roles & Policies)

AWS Budgets

Amazon CloudWatch

Amazon SNS

Linux

Bash shell scripting

Cron jobs

Disk, CPU, memory monitoring

Process and system health checks

📁 Project Structure
aws-cost-tracking-alert-system/
│
├── architecture/
│   └── diagrams/
│
├── aws_setup/
│   ├── billing_alerts.md
│   ├── cloudwatch_alarms.md
│   └── sns_setup.md
│
├── linux_automation/
│   ├── cost_alert_check.sh
│   ├── disk_usage_check.sh
│   ├── system_health.sh
│   └── README.md
│
├── testing_and_alerts/
│   └── alert_testing.md
│
├── learning_and_failures/
│   └── lessons_learned.md
│
└── README.md

 Linux Automation Layer

Linux is used as the first line of detection.

Scripts Included
cost_alert_check.sh

Verifies AWS Budget configuration

Confirms SNS topic readiness

Ensures cost alerts are properly wired

Note: AWS cost data is delayed by design. This script validates alert readiness, not live billing totals.

disk_usage_check.sh

Checks disk usage on EC2

Compares usage against a defined threshold

Sends SNS alert if exceeded

Example alert:

 ALERT: Disk usage exceeded 80%

system_health.sh

Monitors:

CPU usage

Memory usage

Load average

Triggers alert if thresholds are crossed

This script helped me understand the difference between CPU usage vs load average, which is commonly misunderstood.

-> Monitoring & Alerts <-
CloudWatch:
1.Used for EC2 metrics
Alarms configured for:
1.CPUUtilization
2.Instance health
3.Failed status checks
4.AWS Budgets
5.Monthly budget created
6.Threshold alerts configured
7.SNS integrated for email delivery

--> SNS

Single SNS topic used

Email subscription confirmed

Reused across Linux and AWS alerts

-> Testing & Validation <-

I tested alerts by:
1.Manually increasing CPU load
2.Filling disk space
3.Triggering Linux scripts
4.Breaking IAM permissions intentionally
5.Restarting EC2 instances
6.Stopping and starting instances to verify persistence

All alerts were validated through real email notifications.

->  Failures & Lessons Learned <-

1.This project involved many real issues, including:
2.SSH timeouts due to subnet misconfiguration
3.Instances without internet access
4.IAM roles attached but permissions missing
5.SNS messages sent but emails not received
6.AWS CLI failing due to missing role permissions
7.Cost alerts misunderstood due to billing delay
8.Each failure is documented in learning_and_failures/.

These problems taught me how cloud systems actually fail, not just how they work on paper.

-> Cost Awareness <-

1.AWS Free Tier respected
2.Instances stopped when not in use
3.Single SNS topic reused
4.No unnecessary managed services added
5.This project emphasizes cost-conscious cloud operations.

-> What This Project Demonstrates <-

1.Cloud operational thinking
2.Linux + AWS integration
3.Secure IAM usage
4.Monitoring and alerting fundamentals
5.Troubleshooting real cloud issues
6.Writing production-style documentation