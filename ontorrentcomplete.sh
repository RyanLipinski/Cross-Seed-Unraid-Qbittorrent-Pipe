#!/bin/bash
"%N"=$1

#Change the path below to the path of your crosswatch.txt file. This needs to be the filepath as QBittorrent sees it (i.e. the QBittorrent container mapping). Do not remove the quotation marks.
echo $1 >> /scripts/crosswatch/crosswatch.txt
