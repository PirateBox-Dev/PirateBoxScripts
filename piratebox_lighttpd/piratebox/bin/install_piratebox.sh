#!/bin/bash
## PirateBox installer script
##  created by Matthias Strubel   2011-04-04
##
##  * starts apt-get for installing needed packages
##  * copy over the piratebox folder to /opt
##  * asks for installing usb to fstab 
##     -> Create folder /mnt/share
##     -> Add entry to /etc/fstab 
##  ( * Ask for sharefolder for creating a link )
##  * set the correct permissions
##  * optional: create a link to /etc/init.d

