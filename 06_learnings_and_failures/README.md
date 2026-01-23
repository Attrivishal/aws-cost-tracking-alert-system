------------------------------------
# Learning & Failures

This folder documents real problems I faced while building this project and how I resolved them.

Instead of hiding mistakes, I documented them because real cloud engineering involves debugging, not perfect execution.

---

## 1️   EC2 Had Public IP but No Internet Access

Problem:
- EC2 instance had a public IP
- `ping google.com` failed
- Package installation timed out

Root Cause:
- Subnet did not auto-assign public IPv4
- Route table was not correctly associated

Fix:
- Enabled auto-assign public IP on subnet
- Verified route table had Internet Gateway attached

Learning:
A public IP alone does not guarantee internet access.
Subnet routing controls connectivity.

---

## 2️   SSH Connection Timeout

Problem:
- SSH timed out even with correct key
- Security group looked correct

Root Cause:
- Source IP mismatch in SSH inbound rule
- Public IP changed after reconnecting network

Fix:
- Updated SSH rule with correct source IP
- Verified port 22 reachability

Learning:
Most SSH issues are networking issues, not EC2 issues.

---

## 3️   S3 Access Denied from EC2

Problem:
- EC2 could not list or read S3 objects
- IAM role was attached correctly

Root Cause:
- IAM role missing `s3:ListBucket`
- Bucket policy was incomplete

Fix:
- Added required permissions
- Verified role using:
```bash
aws sts get-caller-identity

Learning
S3 access requires correct identity policy AND resource policy.

4️  SNS Alert Sent but Email Not Received

Problem:
- Script returned success message
- No email received
Root Cause:
- SNS subscription was not confirmed
- Wrong SNS topic ARN was used
Fix:
- Confirmed SNS subscription
- Updated scripts with correct topic ARN

Learning:

- SNS returning MessageId does not guarantee delivery.

 5️ SNS Free Tier Confusion (Important Learning)

-Initial assumption
-I assumed AWS Free Tier allows only one SNS topic.

Reality
AWS Free Tier allows:

-Multiple SNS topics
-1 million publishes per month (free)
- 100 email notifications per month (free)

Actual limitation:
- The limitation is on message volume, not topic count.

Learning:

-AWS limits are service-based, not object-based.
- Reading service quotas prevents wrong architectural decisions.