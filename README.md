# Cross-Seed-Unraid-Qbittorrent-Pipe

## Summary

An issue that many users may face when implementing Cross-Seed on their Unraid Machines for Qbittorrent on Unraid is that the command used to instruct Cross-Seed to perform an automatic search on torrent completion will not work within a Docker Container. This is because the shell used by the Docker Container is different than the shell used by Unraid; said another way, the command to be executed on completion of a torrent in Qbittorrent executes within the Docker Container, whereas the Cross-Seed Container lives within the Unraid System, thus a command issued within the Docker Container cannot give a command to the parent Unraid System.

To get around this limitation, the scripts included in this project are designed to perform the following:
- On the completion of a torrent, Qbittorrent is instructed to export the name of the torrent to a text file.
- A script will run on Unraid which will read the text file, and issue the command the command to Cross-Seed to perform a search for the torrent.

## Guide

### Prerequisites

This guide presumes that the following has been set up:

- Cross-Seed is installed and set up on your Unraid Server
- The User Scripts Plugin has been installed from Community Applications
- Qbittorrent (or QbittorrentVPN) is set up and running in a Docker Container

### Files

1. **ontorrentcomplete.sh** - On torrent completion, this script is called by Qbittorrent. This script will append a line to the file with the name of the completed torrent (which Cross-Seed will use to search).

2. **cross-watch.txt** - This is a blank text file that will house the names of all completed torrents which cross-watch-script.sh will use to search. The lines of this file are cleared once searched by cross-watch-script.sh.

3. **cross-watch-script.sh** - This file contains the script to be pasted into a new script using the User Scripts Plugin. When this script is run, it will instruct Cross-Seed to perform a search of each torrent added to cross-watch.txt, and it will clear the line in cross-watch.txt after the search has been performed.

### Guide

1. To begin, download cross-watch.txt, cross-watch-script.sh, ontorrentcomplete.sh
2. Place cross-watch.txt and ontorrentcomplete.sh within a folder on your server to which QBittorrent will have access.
3. **Torrent Completion Script Configuration** Open ontorrentcomplete.sh and adjust the file path on line 3 to point to the location of cross-watch.txt. This needs to be the path that QBittorrent sees.
4. **QBittorrent Configuration** Within QBittorrent, go to Options -> Downloads -> Run External Program. Click the check mark in the box titled "Run external program on torrent finished" and paste the following script into the box (replace the path name with the path name of the folder you created in Step 2). This needs to be the path the QBittorrent sees:

    /scripts/ontorrentcomplete.sh "%N"

5. **User Scripts Configuration** Within the User Scripts Plugin, click "Add New Script". Copy and paste the code within "cross-watch-script.sh" into the code section of your script.
6. **User Scripts Configuration** Within the script that you pasted, edit the input field in line 4 and line 16 to point to the location of crosswatch.txt (set up in step 2). Remember that this needs to be the path that Unraid sees (do not use the container path set up for QBittorrent).
7. **User Scripts Configuration** Update the ip address in line 9 to point to the local ip address for Cross-Seed. Save and exit the script.
8. **User Scripts Configuration** Adjust the frequency you want to run the script in the User Scripts GUI, this determines the frequency by which you want completed torrents to be searched.
9. **Testing** To test this script, download a torrent within QBittorrent. Upon the completion of the torrent, open cross-watch.txt and validate that the torrent name has been added to the text file. Then manually run the script you created in User Scripts. Read the logfile for Cross-Seed to ensure that the torrent has been searched. Finally, open the cross-watch.txt file again and ensure that the name of the torrent has been removed/the file is blank.
