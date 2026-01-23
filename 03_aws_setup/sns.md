--------------------------------------------------------------
# SNS Notification Setup

This file documents how Amazon SNS was used to deliver alerts generated
by billing and CloudWatch alarms.

---

## Why SNS Was Needed

Alerts are useless if they are not delivered to the right place.
SNS acts as the notification layer for this project.

---

## SNS Topic Setup

- Created an SNS topic dedicated to alerts
- Subscribed my email address to the topic
- Confirmed the subscription manually

---

## Alert Flow

1. Billing or CloudWatch alarm changes state
2. Alarm publishes a message to SNS
3. SNS delivers the notification via email

This flow ensures alerts are received in real time.

---

## Verification

I tested SNS by triggering alarms manually and confirmed
that email notifications were delivered successfully.

---

## Key Learning

SNS decouples monitoring from notification delivery.
This makes the alerting system flexible and scalable.
