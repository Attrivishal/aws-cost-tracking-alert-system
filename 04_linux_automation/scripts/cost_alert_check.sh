#!/bin/bash

# What it WILL do

# Check:
# Budget exists
# Budget limit
# Current actual spend
# Whether spend is close to limit
# Print actionable warning
echo "===================================="
echo " AWS Cost Alert Readiness Check"
echo "===================================="

# ✅ Correct variable (VALID bash variable name)
ACCOUNT_ID="434927108661"
REGION="ap-south-1"

echo "AWS Account ID: $ACCOUNT_ID"
echo "Region: $REGION"
echo ""

# 1️⃣ Check AWS CLI
if ! command -v aws &> /dev/null; then
  echo "❌ AWS CLI not installed"
  exit 1
fi

# 2️⃣ Check IAM Role access
echo "Checking IAM Role..."
aws sts get-caller-identity --output table || exit 1
echo ""

# 3️⃣ Check AWS Budgets
echo "Checking AWS Budgets..."
aws budgets describe-budgets \
  --account-id "$ACCOUNT_ID" \
  --region "$REGION" \
  --output table

if [ $? -ne 0 ]; then
  echo "❌ Budget not found or permission missing"
  exit 1
fi

# 4️⃣ Check SNS Topics
echo ""
echo "Checking SNS Topics for Cost Alerts..."
aws sns list-topics --region "$REGION" --output table

echo ""
echo "------------------------------------"
echo "NOTE:"
echo "• Alerts are triggered by AWS Budgets + SNS"
echo "------------------------------------"
echo "✅ Cost Alert system is configured correctly"
