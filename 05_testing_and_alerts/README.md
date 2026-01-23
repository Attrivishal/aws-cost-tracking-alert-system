---------------------------------------------
# Testing & Alert Validation

This folder documents how I tested the alerting system end-to-end by intentionally creating real system stress and verifying that alerts were delivered successfully.

The goal was to ensure that alerts are not just configured, but actually work under real conditions.

---

## Why testing is important

Creating alarms and scripts is not enough in real systems.
I tested this project by simulating failures and high usage scenarios to confirm that:

- Monitoring detects the issue
- Alerts are triggered correctly
- Notifications reach the user via SNS

---

## Tests Performed

### 1️  Disk Usage Alert Test

What I tested:
- Disk usage threshold breach on EC2

How I tested:
fallocate -l 1G testfile 
# it create 1gb instant file 


Then I ran:
./disk_usage_check.sh

Expected behavior:
- Disk usage crosses defined threshold
- Script detects the breach
- SNS alert email is sent

Result:
- Disk usage alert triggered successfully
- Email notification received


2️ CPU Load Alert Test:
What I tested:

- High CPU load on EC2
How I tested:
yes > /dev/null &
yes > /dev/null &
yes > /dev/null &

Then I ran:
./system_health.sh

- Expected behavior
- CPU usage increases
- Load average rises
- Script dentifies unhealthy state
- SNS alert is sent

Result:
- Load spike detected
- SNS notification triggered

3️ CloudWatch Alarm Validation

What I tested:
- CloudWatch CPUUtilization alarm

How I tested:
- Created CloudWatch alarm for CPU threshold
- Generated CPU load manually
- Observed alarm state transition

Result:
- Alarm moved to ALARM state
- SNS notification received