#!/bin/bash

# Store the user options in an array
main=("System Admin Menu" "Security Admin Menu" "Quit")
system=("Running Processes" "Running Services" "Installed Software" "All Users" "Main Menu" "Exit")
security=("Last 10 User Logins" "Last 20 Lines of Log" "lsof -i -n" "lsof Specific Process" "Main Menu" "Exit")

# Create functions for both submenus
function system_admin {
  while true; do
    PS3="Enter a number: "
    echo "------------------------------------------------------"
    select option in "${system[@]}"; do
      case $option in

        "Running Processes")
          # Use "ps" to show the running processes. "a" shows all users, "u" provides better formatting, and "x" shows processes not on the terminal.
          ps aux
          break
          ;;

        "Running Services")
          # Use systemctl to show all running services.
          systemctl list-units --type=service --state=running
          break
          ;;

        "Installed Software")
          # Use dpkg to show all installed packages. Assumes the script is running on Debian-based distros.
          dpkg --list
          break
          ;;

        "All Users")
          # List all users from /etc/passwd using "getent passwd", get specific values using "cut", and format/label them with "column"
          getent passwd | cut -d: -f1,3,4,6,7 | column -t -s ":" -N "Username","UID","GID","Home Dir","Shell"
          break
          ;;

        "Main Menu")
          return
          ;;

        "Exit")
          exit 0
          ;;

        *)
          echo "Invalid option"
          ;;

      esac
    done
  done
}

function security_admin {
  while true; do
    PS3="Enter a number: "
    echo "------------------------------------------------------"
    select option in "${security[@]}"; do
      case $option in

        "Last 10 User Logins")
          # Use the command "last -n" to print the previous n user logins.
          last -n 10
          break
          ;;

        "Last 20 Lines of Log")
          # This prompt is to satisfy option 2a. Prompt if the user wants to view the log files.
          echo "Would you like to list the available log files? (y/n)"
          read answer
          if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
            ls -la /var/log
          fi

          # Allow the user to read a specific log file, or syslog by default.
          echo "-----------------------------------------------------------"
          echo "Please enter a log to read (default is syslog if none is provided)"
          read log
          if [ -z $log ]; then
            tail -n 20 /var/log/syslog
          else
            tail -n 20 "/var/log/$log"
          fi
          break
          ;;

        "lsof -i -n")
          # Literally just lsof -i -n
          lsof -i -n
          break
          ;;

        "lsof Specific Process")
          # Using a regular expression to check if the answer is a number, either search for process by PID or name.
          echo "Please enter either the name or PID of the process to view"
          reg='^[0-9]+$'
          read process
          if [[ $process =~ $reg ]]; then
            lsof -p $process
          else
            lsof -c $process
          fi
          break
          ;;

        "Main Menu")
          return
          ;;

        "Exit")
          exit 0
          ;;

        *)
          echo "Invalid option"
          ;;
      esac
    done
  done
}


# Use select with nested loops to make the prompts.
PS3="Enter a number: "
while true; do
  echo "------------------------------------------------------"
  select main_option in "${main[@]}"; do

    case $main_option in
      "System Admin Menu")
        # Call the System Admin menu
        system_admin
        ;;

      "Security Admin Menu")
        # Call the Security Admin menu
        security_admin
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
