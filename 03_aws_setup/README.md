------------------------------------------------------
Purpose of This Layer

This folder documents how I set up the AWS-side foundation for the project.
The goal of this layer is to make AWS capable of:

Tracking cloud costs

Monitoring infrastructure health
Sending alerts reliably
Working securely with EC2 without access keys

This layer acts as the control plane of the project.
Linux scripts only trigger checks — AWS handles visibility, alerts, and delivery.

-> What This Layer Covers <-

This folder includes configuration and explanation for:

AWS Budgets (cost monitoring)

CloudWatch (metrics & alarms)

SNS (alert notifications)

IAM roles (secure access for EC2)

Each file in this folder focuses on one AWS responsibility.

 Files in This Folder:

1️. billing_alerts

Why Billing Alerts Are Needed
AWS costs do not fail loudly.
If cost alerts are not configured, billing issues are discovered too late.

I configured AWS Budgets so that:

Monthly cost thresholds are defined

Alerts are triggered when limits are crossed

Notifications are sent automatically

Key Learnings:
AWS cost data is delayed by design
Linux cannot fetch live billing totals
Budgets + SNS is the correct AWS-native approach
What I Configured
Monthly budget
Percentage-based alerts

SNS integration for email notifications

 Image to add:

AWS Budget overview page
Budget alert threshold configuration
SNS notification trigger preview

2️  cloudwatch_alarms
Why CloudWatch Is Used:
Linux scripts are good for local checks, but:

AWS infrastructure needs centralized monitoring
Instance health must be tracked even if scripts fail
Alerts must persist beyond a single server

CloudWatch provides:

Real-time EC2 metrics
Health status monitoring
Alarm-based automation

Metrics I Used:
CPUUtilization
StatusCheckFailed
Instance health state

What I Learned:

CPU usage ≠ load average
Alarms must be tested manually
Alarm state transitions matter (OK → ALARM)

 Image to add:

CloudWatch alarm configuration
Alarm in ALARM state
Metric graph with threshold line

3️  sns_setup
Why SNS Is Critical
Alerts are useless if they are not delivered.

SNS is used as:

The single notification channel
A bridge between AWS services and human response
A reusable alert endpoint
Design Decision

I intentionally used one SNS topic for:

CloudWatch alarms
Linux script alerts
Cost alerts

This avoids:

SNS sprawl

Confusing subscriptions

Free-tier misuse

Real Issue I Faced

SNS messages were sent unsuccessfully
Emails were not delivered

Root cause: subscription not confirmed

This helped me understand the difference between:

“Message published” vs “Alert received”

Image to add:

SNS topic details
Confirmed email subscription
Message publish success

IAM Design in This Layer

I did not use access keys on EC2.

Instead:

IAM role attached to EC2
Least-privilege policies
Temporary credentials via metadata service

This design:
Improves security
Matches real production setups
Prevents credential leakage
 
Image to add
IAM role attached to EC2
Policy summary page

 How This Layer Connects to the Project:
Linux Scripts
   │
   │  (checks system / cost state)
   ▼
AWS Setup Layer
   ├─ Budgets detect cost thresholds
   ├─ CloudWatch monitors metrics
   ├─ SNS delivers alerts
   └─ IAM secures access


Without this layer:

Linux scripts would be isolated
Alerts would not scale
Cost awareness would be missing

 Problems I Faced & Fixed:

Budget alerts not triggering due to missing thresholds
CloudWatch alarms created but never tested
SNS emails not received due to unconfirmed subscription
IAM role attached but missing required permissions
Each issue was debugged and documented during implementation.

 What This Layer Demonstrates:

Cost-aware cloud design
Real monitoring setup (not just dashboards)
Secure IAM usage
Alert reliability and testing
Understanding AWS operational behavior