#!/bin/bash

# First, check if the user provided some data to the script and alert them if not.
if [ -z "$1" ]; then echo "Please provide an IP range to scan (only /24 ranges supported)"; else

	#Create the final octet that will be looped through and store it in a variable.
	final_octet=$(seq 1 254)

	#Trim the user's input to only grab the network IP
	network_ip=$(echo $1 | grep -oE '([0-9]{1,3}\.){3}')

	if [ -z "$network_ip" ]; then echo "Invalid IP address, please provide the full network address."; else

		#Perform nslookups for each IP in the given range.
		for i in $final_octet[@]
		do
			nslookup "$network_ip$i"
		done
	fi
fi
