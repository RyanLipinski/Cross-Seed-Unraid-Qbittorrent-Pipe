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
2. Place all three files within a folder on your server that Qbittorrent and Cross-Seed both have access to. It is recommended that the file mappings to this folder are consistent between Qbittorrent and Cross-Seed.
3. **QBittorrent Configuration** Within QBittorrent, go to Options -> Downloads -> Run External Program. Click the check mark in the box titled "Run external program on torrent finished" and paste the following script into the box (replace the path name with the path name of the folder you created in Step 2, remember that this needs to be the path the QBittorrent sees):

    /scripts/ontorrentcomplete.sh "%N"

4. **User Scripts Configuration** Within the User Scripts Plugin, click "Add New Script"
