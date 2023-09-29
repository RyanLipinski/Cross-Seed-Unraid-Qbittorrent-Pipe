#!/bin/bash

input="/mnt/user/scripts/crosswatch/crosswatch.txt"

while IFS= read -r line
do
	curl -XPOST http://192.168.1.1:2468/api/webhook --data-urlencode "name=$line"
	sleep 20
done < "$input"

> /mnt/user/scripts/crosswatch/crosswatch.txt