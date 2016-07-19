#!/bin/bash

DIR="/cygdrive/d/Sandbox/"
TIME=1
CHECKOUT_DIR="./checkout/version3.1"

if [[ $1 == "d" || $1 == "dir" ]]; then
	echo "Enter a valid project directory to search through"
	read DIR
	echo "Enter a valid time [1 for past day, 2 for past 2 days etc] to search through"
	read TIME
fi

echo "Searching..."

changed_files=($(find $DIR -type f -mtime -$TIME -regextype "posix-extended" -iregex '.*\.(h|cpp)')) 

if [[ $1 == "show" || $1 == "s"  || $2 == "show" || $2 == "s" ]]; then
	printf '%s\n' "${changed_files[@]}"
	echo "Done"
	exit 1
fi

echo "Do you want to use $CHECKOUT_DIR as the checkout dir? [y/n]"
read yn
if [[ $yn == "no" || $yn == "n" ]]; then
	echo "Please specify a valid git directory"
	read CHECKOUT_DIR
fi

echo "Copying..."

for file in ${changed_files[@]}; do
	echo $file
	cp $file $CHECKOUT_DIR
done

echo "State of $CHECKOUT_DIR"
ls $CHECKOUT_DIR

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
