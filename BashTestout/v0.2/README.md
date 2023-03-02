# Bash Test-Out Code Repository
## Expectations
1. Create a for loop that uses the command "seq" to print the last octet for a subnet and print the IP and domain name for a network that the user specifies via the command line. (NOTE You'll need to use a tool to perform a DNS lookup. Also, only write this for a /24 network.)

For example, I should be able to type:

script.bash 192.168.1.0/24

and the output should be something like:

192.168.1.30 - www.dunston.com

for the entire subnet.

Test using the LAN 192.168.4.0/24 on the Skiff network or use the Champlain network.

2. Using only awk and sed, parse this access.log.txt

Download access.log.txt and create a CSV file with the headers:

IP, Date, Method, URI, User Agent

The fields in the CSV file should be enclosed in quotes and separated by commas.

In the date field, be sure the square brackets are removed in the output.

When imported into an excel spreadsheet, the output should be in a nice columnar output.

3. Create a menu with a System Administrator and Security Administrator submenu.

When the user selects the System Administrator menu the user should be able to:

1. List all running processes
2. List all running services
3. List all installed software
4. List all users (display their username, user and Group ID, home directory and shell)

The headers should be: Username, UID/GID, Home Dir, Shell
5. Return to main menu
6. Exit

The security administrator menu should be able to:

1. List last 10 logged in users
2. Print the last 20 lines of an arbitrary file in the /var/log/ directory
  a. Print the available files to the user so they can select which file to print
3. Run the command: lsof -i -n
4. Use lsof to print the details of a specific process or process ID
5. Return to main menu
6. exit

Process each of the options with a case statement. Use the less command to show one page of output at a time and allow the user to scroll through. When the user presses "q" to stop browsing the output, take them to the menu they were in.

4. Write a script to download the files:

  https://rules.emergingthreats.net/blockrules/emerging-botcc.rules

  https://rules.emergingthreats.net/blockrules/compromised-ips.txt

  and create a Cisco, netscreen, and iptables ruleset to drop the IPs.

  https://www.cisco.com/c/en/us/support/docs/ip/access-lists/26448-ACLsamples.html#anc6

5. Use YAD to create a GUI for #4 above.

  http://smokey01.com/yad/

  Links to an external site.

 

When you are done, I will set up a meeting with you to go over the programs you've written.
