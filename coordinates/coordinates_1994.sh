#!/bin/bash

# you need to change the path for the file here
dir=$HOME/goship/1994

echo "file lat lon"
for file in $(ls $dir)
do
	lat_lon=$(cat $dir/$file | awk 'NR >= 16 && NR <= 17' | awk '{print $3}')
	lat=$(echo $lat_lon | awk 'NR == 1')
	lon=$(echo $lat_lon | awk 'NR == 2')
	echo "$file $lat $lon"
done
