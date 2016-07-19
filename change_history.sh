#!/bin/bash

echo "Searching..."

changed_files=($(find /cygdrive/d/Sandbox/ -type f -mtime -1 -regextype "posix-extended" -iregex '.*\.(h|cpp)')) 

if [[ $1 == "show" || $1 == "s" ]]; then
	printf '%s\n' "${changed_files[@]}"
	echo "Done"
	exit 1
fi

echo "Copying..."

for file in ${changed_files[@]}; do
	echo $file
	cp $file ~/checkout/version3.1
done

echo "State of checkout/version3.1"
ls ./checkout/version3.1/
echo "Do you want to check files in? [y/n] "

read yesno
if [[ $yesno == "yes" || $yesno == "y" ]]; then
	echo "Running gitScript..."
	cd ./checkout/
	/bin/bash gitScript.sh
fi
echo "Done"

# Uncomment for when you want to run in background
#sleep 300
