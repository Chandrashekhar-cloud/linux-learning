#!/bin/bash
read -p 'Enter file or folder path: ' PATH_INPUT

if [ -f " $PATH_INPUT" ];then
	echo 'it is a file'
	echo 'Size: $(stat -c%s "$PATH_INPUT") 'bytes'
	echo 'Lines: $(wc -1 < "$PATH_INPUT")
elif [ -d "$PATH_INPUT" ]; then
	echo 'It is a Directory'
	echo 'Contents:'
	ls -la "$PATH_INPUT"
else
	echo 'path does not exist!'
fi
