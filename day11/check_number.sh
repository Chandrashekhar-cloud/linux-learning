#!/bin/bash
read -p 'Enter a number: ' NUM

if [ $NUM -gt 100 ]; then
	echo 'Larger number (>100)'
elif [ $NUM -gt 50 ]; then
	echo 'Medium number (51-100)'
elif [ $NUM -gt 0 ]; then
	echo 'Small number(1-50)'
elif [ $NUM -eq o ];then
	echo 'Zero'
else
	echo'Negative number'
fi
