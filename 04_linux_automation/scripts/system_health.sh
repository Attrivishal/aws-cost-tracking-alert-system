#!/bin/bash

echo "===================================="
echo " System Health Check"
echo "===================================="

# 1️  CPU Load
echo ""
echo "CPU Load:"
uptime

# 2️ Memory Usage
echo ""
echo "Memory Usage:"
free -h

# 3️  Disk Usage
echo ""
echo "Disk Usage:"
df -h /

# 4️  Top CPU-consuming processes
echo ""
echo "Top Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

# 5️  Network connectivity check
echo ""
echo "Network Connectivity Check:"
if ping -c 2 8.8.8.8 >/dev/null 2>&1; then
  echo "✅ Network connectivity OK"
else
  echo "❌ Network connectivity FAILED"
fi

# 6️  SSH service status
echo ""
echo "SSH Service Status:"
systemctl is-active ssh >/dev/null 2>&1 && echo "✅ SSH service running" || echo "❌ SSH service not running"

echo ""
echo "===================================="
echo " Health Check Completed"
echo "===================================="
