--------------------------------------------------
# CloudWatch Monitoring Setup

This file explains how I used Amazon CloudWatch to monitor system-level metrics
for the EC2 instance used in this project.

The goal was to detect abnormal behavior early, not just react after failures.

---

## Metrics Used

I monitored standard EC2 metrics such as:
- CPUUtilization
- StatusCheckFailed
- Network activity

These metrics reflect the real health of a running instance.

---

## CloudWatch Alarms

I created CloudWatch alarms with defined thresholds, for example:
- CPU usage crossing a safe limit
- Instance status check failures

Each alarm was configured to change state when metrics crossed thresholds.

---

## Alarm States

- OK: System operating normally
- ALARM: Metric outside expected range
- INSUFFICIENT_DATA: Not enough data available

Understanding these states helped me interpret alerts correctly.

---

## Integration with SNS

CloudWatch alarms were connected to SNS topics.
This ensured alerts were sent automatically without manual checking.

---

## Key Learning

Monitoring is not just about dashboards.
Alarms + notifications are what make monitoring useful in real systems.
