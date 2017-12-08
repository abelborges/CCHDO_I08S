#!/bin/bash

# you need to change the path for the file here
DIR=$HOME/goship/2016

echo "file lat lon"
for file in $(ls $DIR)
do
	if [[ $(echo $file | cut -d'_' -f 2) < "00009" ]]; then
		lat_lon=$(cat $DIR/$file | awk 'NR >= 53 && NR <= 54' | awk '{print $3}')
	else
                lat_lon=$(cat $DIR/$file | awk 'NR >= 52 && NR <= 53' | awk '{print $3}')
	fi
	lat=$(echo $lat_lon | awk 'NR == 1')
	lon=$(echo $lat_lon | awk 'NR == 2')
	echo "$file $lat $lon"
done
