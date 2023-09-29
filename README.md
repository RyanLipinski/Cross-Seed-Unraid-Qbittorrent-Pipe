# Cross-Seed-Unraid-Qbittorrent-Pipe

An issue that many users may face when implementing Cross-Seed on their Unraid Machines for Qbittorrent on Unraid is that the command used to instruct Cross-Seed to perform an automatic search on torrent completion will not work within a Docker Container. This is because the shell used by the Docker Container is different than the shell used by Unraid; said another way, the command to be executed on completion of a torrent in Qbittorrent executes within the Docker Container, whereas the Cross-Seed Container lives within the Unraid System, thus a command issued within the Docker Container cannot give a command to the parent Unraid System.

To get around this limitation, the scripts included in this project are designed to perform the following:
- On the completion of a torrent, Qbittorrent is instructed to export the name of the torrent to a text file.
- A script will run on Unraid which will read the text file, and issue the command the command to Cross-Seed to perform a search for the torrent.
