#!/bin/bash

THRESHOLD=20
MOUNT_POINT="/"
SNS_TOPIC_ARN="arn:aws:sns:ap-south-1:434927108661:HighCPUUsage"
REGION="ap-south-1"

echo "===================================="
echo " Disk Usage Health Check"
echo "===================================="

USAGE=$(df -h "$MOUNT_POINT" | awk 'NR==2 {print $5}' | tr -d '%')

echo "Mount Point: $MOUNT_POINT"
echo "Current Disk Usage: ${USAGE}%"
echo "Threshold: ${THRESHOLD}%"
echo ""

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  MESSAGE="ALERT: Disk usage on EC2 exceeded ${THRESHOLD}%. Current u>

  echo "❌ $MESSAGE"
  echo "Sending SNS alert..."

  aws sns publish \
    --region "$REGION" \
    --topic-arn "$SNS_TOPIC_ARN" \
    --message "$MESSAGE" \
    --subject "EC2 Disk Usage Alert"

else
  echo "✅ Disk usage is within safe limits"
fi


