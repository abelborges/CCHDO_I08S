#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Enter the year as first argument, please."
	exit 1
fi

dir=$HOME/goship/$1

for file in $(ls $dir)
do
	begin_table=$(grep "DBAR" $dir/$file -n | cut -d ':' -f 1)
	end_table=$(grep "END_DATA" $dir/$file -n | cut -d ':' -f 1)
	sed -n "$(expr $begin_table + 1),$(expr $end_table - 1) p" $dir/$file > $dir/new_$file
done
