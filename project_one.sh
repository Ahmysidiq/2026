#!/bin/bash

print_section() {
	echo 
	echo " = = = = = = = = = = = = = = = = = = = = = = = "
	echo "$1"
	echo " = = = = = = = = = = = = = = = = = = = = = = = "
		}

print_section " Network Reachability and services "

echo " [+] Network interfaces and IP addresses:"
ip a | grep -E "^[0-9] | inet "

echo
echo "[+] Routing information"
ip route

echo
echo "[+] Listening ports ( TCP/UDP ) :"
ss -tuln	


#Files and permission scan

print_section "Files and Permissions"

echo "[+] world-writable files (top10): "
find / -type f -perm -o=w 2>/dev/null head -n 10

echo
echo "[+] SUID binaries (run as owner):"
find / -type f -perm -4000 2>/dev/null


#Users with Previleges

print_section " User with Odd privileges"
echo "[+] Current user identity and grous"
id

print_section "Processes running"
echo "[+] Processes running as root"
pe -eo user, pid, cmd | grep '^root' | head -n 10

echo " Processes listening on Networks"
echo
echo "[+] Listening processes and associated service in networks again.:" 
ss -tunp

#Enumerating Logs
print_section " Logs that show interesting activity"
LOGFILE="/va/log/auth.log"

if [ -f "$LOGFILE" ]; then
	echo "[+] previously had a failed login attempt"
	grep "FAiled pasword" "$LOGFILE" | tail -n 5
	
	echo
	echo "[+] Recent successful logins:"
	grep "Failed password" "LOGFILE" | tail -n 5
else 
	echo "[-] Authentication log not found."
fi
