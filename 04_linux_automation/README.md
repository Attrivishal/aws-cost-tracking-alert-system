---

-- Why Linux is part of this project--

This project is not only about AWS services.
In real production environments, cloud resources are useless without Linux operations.

I used Linux here to:

 ->Validate AWS alerts from inside EC2

 ->Perform system-level health checks

 ->Simulate real incidents (disk pressure, CPU load)

 ->Send alerts using AWS SNS directly from Linux

This proves that I can operate cloud infrastructure, not just create it.

 -> What this layer does

This layer contains three focused Linux automation scripts, each solving one real operational problem:

   Script                    |          Purpose
 cost_alert_check.sh         |        Verifies AWS cost alert readiness
 disk_usage_check.sh         |        Monitors disk usage & sends alerts
 system_health.sh            |        Monitors CPU, memory & load

Each script is:
 ->Small
 ->Purpose-specific
 ->Production-style
 ->Runnable directly on EC2


Script 1: Cost Alert Verification
cost_alert_check.sh
What this script does

Linux cannot calculate AWS billing in real time.
AWS cost data is delayed by design.

So instead of doing something fake, this script verifies:

 ->AWS Budgets exist
 ->SNS topic for cost alerts exists
 ->EC2 has permission to read budget status


What I check using this script:

 ->AWS Account ID
 ->Budget configuration
 ->Alert readiness (via Budgets + SNS)

How i ran it:
 Open your bash terminal:
  chmod +x cost_alert_check.sh  // For giving the executable permission 
  ./cost_alert_check.sh         // how to run the script



Script 2: Disk usage Monitoring
why this matters: 
 Disk exhaustion is one of the top cause of production outages
  
   I implemented 
    -> Disk usage thresholds check
    -> Automatic SNS alert if thresholds is crossed

This simulates real on-call alerts
  -> Root filesystem usage(/)
  -> Compare usage against threshold
  -> sends SNS notification if exceeded

How is tested it:
 I intentionally lowered the thresholds to trigger alerts
  open your bash terminal:
    ./disk_usage_check.sh    // how to run the sript file 



Script 3: System Health Monitoring
system_health.sh

What this script monitors
  ->CPU usage
  ->Memory usage
  ->Load average

If load crosses a safe threshold:
  ->SNS alert is sent
  ->Incident is logged

  How I generated load:
      ->yes > /dev/null &

Then ran:
  ./system_health.sh

Why this is important
This proves:
  ->I understand Linux performance metrics
  ->I can simulate incidents
  ->I can validate alerting pipelines end-to-end