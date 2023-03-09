#!/bin/bash

f=$1

# First, check if the user provided some data to the script and alert them if not.
if [ -z "$f" ]; then echo "Please provide an access log file to parse."; else

	# Start the CSV file by providing the column names
	echo "IP,Date,Method,URI,User Agent" > output.csv

	# Grab only the columns we need from the provided access log file.
	# I specify "," as the separator to prepare for the CSV format.
	# I also use print while setting awk to a variable to create an array of each line to process later.
	# I use printf to prevent awk from creating multiple lines.
	needed=$(awk '{printf("%s,%s,%s,%s,", $1, $4, $6, $7); for (i = 12; i <=NF; i++) printf "%s ",$i; print ""}' $f)

	# Then, use sed to add quotes to the columns and remove square brackets
	while read -r line
	do
		formatted_line=$(echo $line | sed 's/^/\"/' | sed 's/,/\",\"/' | sed 's/,/\",/2' | sed 's/,/\",\"/3' | sed 's/,/\",/4' | sed 's/\[//')

		# Finally, append to the CSV file
		echo "$formatted_line" >> output.csv
	done <<< "$needed"
	echo "The file has been parsed successfully. The file 'output.csv' has been created in the directory that this script was run from."
fi
