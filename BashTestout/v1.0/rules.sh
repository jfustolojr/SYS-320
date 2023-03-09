#!/bin/bash

# This file fills both requirements 4 and 5. The file is split into two sections.
# Each section will be labelled with which requirement is being fulfilled.

# Ensure that the script is run with sudo permissions.
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Requirement 5 - YAD GUI for requirement 4.

# Set default values
cisco="./cisco_rulesets.txt";
netscreen="./netscreen_rulesets.txt";
iptables="./iptables_rulesets.txt";

# Create the GUI that the user will interact with.
form=$(yad --form --center --width=300 --title "Ruleset Creation Script" \
    --text="Please enter the path/filename to output to." \
    --separator=" " \
    --field="Cisco Ruleset Output File" \
    --field="Netscreen Ruleset Output File" \
    --field="Iptables Ruleset Output File" \
    --buttons-layout=center \
    --button="Run":1 \
    --button="Cancel":0 \
) result=$?

if [ $result -eq 1 ]; then
  # Set filename variables based on user input.

  #After much research into yad, I couldn't find a way to assign field data
  #into variables. I've tried using echo with awk to assign it but everytime
  #it results in an empty variable. I've admittedly even asked ChatGPT which
  #couldn't figure out why this was happening so I was out of options. The
  #script works, but doesn't allow for custom filenames.

  #cisco"${form[0]}"
  #netscreen="${form[1]}"
  #iptables="${form[2]}"
  echo ""

else
  # The user clicked on the "Cancel" button so exit the script.
  echo "The script's execution was cancelled by the user"
  exit 0
fi

# Requirement 4 - Ruleset creation

# Then, pull the required files
wget https://rules.emergingthreats.net/blockrules/emerging-botcc.rules
wget https://rules.emergingthreats.net/blockrules/compromised-ips.txt

cp compromised-ips.txt full_ips.txt

# Pull IP addresses from the emerging-botcc.rules file
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' emerging-botcc.rules | tr ' ' '\n'  >> full_ips.txt

# Sort IP addresses and remove duplicates
sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n -o full_ips.txt full_ips.txt

i=10

touch "$cisco" "$netscreen" "$iptables"

while read -r ip
do
  # Create Cisco ruleset for each IP address
  echo "access-list $i deny ip $ip any" >> "$cisco"

  # Create netscreen ruleset for each IP address
  echo 'set policy id ' $i ' from "Trust" to "Untrust" ' $ip ' "ANY" "ANY" deny' >> "$netscreen"

  # Create iptables rules using the command
  iptables -A INPUT -s $ip -j DROP

  i=$(($i+1))
done < full_ips.txt

# When the rule creation is complete, export the current iptables to a file.
iptables-save > "$iptables"

# Where files were created under sudo permissions, allow user access to each file.
chmod 777 "$cisco" "$netscreen" "$iptables"

# Cleanup
rm full_ips.txt emerging-botcc.rules compromised-ips.txt

echo "The ruleset creation completed successfully. The three files have been created in the directory where this script was executed from."
