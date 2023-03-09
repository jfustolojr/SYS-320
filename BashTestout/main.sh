#!/bin/bash

# Main menu file for the bash testout assignment.

main=("DNS Lookup" "Log Parser" "Admin Menu" "Rulesets (requires root)" "Quit")

#Main prompt
PS3="Enter a number: "
while true; do
  echo "------------------------------------------"
  select main_option in "${main[@]}"; do

    case $main_option in
      "DNS Lookup")
        # Ask for a network address, and call the script
        echo "Please provide a network IP to scan. (Only /24 addresses supported)"
        read ip
        ./v1.0/octet.sh $ip
        ;;

      "Log Parser")
        # Ask for the log file location and execute the parser script
        echo "Please provide the path to the log file"
        read path
        ./v1.0/parse.sh $path
        ;;

      "Admin Menu")
        # Execute the admin menu script
        ./v1.0/admin.sh
        ;;

      "Rulesets (requires root)")
        # Execute the rulesets script
        sudo ./v1.0/rules.sh
        ;;

      "Quit")
        exit 0
        ;;

      *)
        echo "Invalid option"
        ;;

    esac
    break
  done
done
