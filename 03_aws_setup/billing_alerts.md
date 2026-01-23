----------------------------------------
# AWS Billing Alerts Setup

This file documents how I configured AWS billing alerts to track cloud spending
and avoid unexpected charges while working on this project.

Since this project is built on a Free Tier account, cost visibility was critical.

---

## Why Billing Alerts Were Required

Cloud costs can increase silently if:
- EC2 instances are left running
- Data transfer increases
- Additional services are enabled by mistake

I wanted an early warning system before costs crossed safe limits.

---

## Billing Alert Configuration

- Enabled billing alerts at the account level
- Created a billing alarm using AWS billing metrics
- Set a low threshold to stay within Free Tier usage

Example threshold:
- Alert when estimated charges exceed a small amount

---

## Notification Flow

Billing alerts were connected to Amazon SNS.
When the threshold is crossed:
- AWS triggers the alarm
- SNS sends an email notification

This ensures I am informed immediately, without logging into the console.

---

## Key Learning

Billing alerts are not enabled by default.
They must be manually activated and verified.

This setup helped me keep the project cost-aware from day one.
