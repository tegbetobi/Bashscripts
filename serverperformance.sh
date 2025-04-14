
#!/bin/bash

# server-stats.sh - Basic Server Performance Stats

echo "===== SERVER PERFORMANCE STATS ====="
echo ""

# Stretch: OS Version
echo ">> OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2
echo ""

# Stretch: Uptime and Load Average
echo ">> Uptime and Load Average:"
uptime
echo ""

# CPU Usage
echo ">> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
  awk '{print "Used: " $2 + $4 "%, Idle: " $8 "%"}'
echo ""


# Disk Usage
echo ">> Disk Usage:"
df -h --total | awk 'END {
  printf("Used: %s, Available: %s, Usage: %s\n", $3, $4, $5)
}'
echo ""


# Stretch: Logged-in Users
echo ">> Currently Logged-in Users:"
who
echo ""

# Stretch: Failed Login Attempts (last 24h)
echo ">> Failed Login Attempts (last 24h):"
journalctl _COMM=sshd --since "24 hours ago" | grep "Failed password" | wc -l
echo ""

echo "===== END OF REPORT ====="
