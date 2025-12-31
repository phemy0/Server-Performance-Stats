#!/bin/bash  

echo -e
lsb_release -a

# Uptime!!

uptime -p

# OS version
echo -e "\n🖥️ OS Version:"
cat /etc/os-release | grep -E 'PRETTY_NAME' | cut -d= -f2 | tr -d '"'

# Uptime
echo -e "\n⏱️ Uptime:"
uptime -p

# Load average
echo -e "\n📊 Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

# CPU usage
echo -e "\n⚡ Total CPU Usage:"
mpstat 1 1 | awk '/Average:/ {printf "User: %.2f%%, System: %.2f%%, Idle: %.2f%%\n", $3, $5, $12}'

# Memory usage
echo -e "\n💾 Memory Usage:"
free -h | awk '/Mem:/ {printf "Used: %s, Free: %s, Usage: %.2f%%\n", $3, $4, ($3/$2)*100}'

# Disk usage
echo -e "\n📂 Disk Usage:"
df -h --total | grep total | awk '{printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'

# Top 5 processes by CPU
echo -e "\n🔥 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory
echo -e "\n🧠 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Logged in users
echo -e "\n👥 Logged in Users:"
who

# Failed login attempts (requires root for /var/log/auth.log)
echo -e "\n🚨 Failed Login Attempts:"
if [ -f /var/log/auth.log ]; then
    grep "Failed password" /var/log/auth.log | wc -l | awk '{print $1 " failed attempts"}'
else
    echo "Auth log not available or requires root access."
fi

echo "======================================"
echo "        END OF REPORT                  "
echo "======================================"

