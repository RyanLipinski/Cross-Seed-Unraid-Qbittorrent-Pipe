#!/bin/bash

#Change the path below to the path of your crosswatch.txt file. This needs to be the filepath as Unraid sees it (i.e. do not use the container path of your QBittorrent instance). Do not remove the quotation marks.
input="/mnt/user/scripts/crosswatch/crosswatch.txt"

while IFS= read -r line
do
	#Change the ip address below to point to the ip address and port of your cross-seed docker.
 	curl -XPOST http://192.168.1.1:2468/api/webhook --data-urlencode "name=$line"

 	#Optional: change the number of seconds to wait between searches. It is not recommended to set this below 2.
 	sleep 20
done < "$input"

#Change the path below to the path of your crosswatch.txt file. This needs to be the filepath as Unraid sees it (i.e. do not use the container path of your QBittorrent instance). Do not add quotation marks.
> /mnt/user/scripts/crosswatch/crosswatch.txt
