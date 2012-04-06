#!/bin/bash
#
#
#
#                                                                                                     
# _|_|_|_|_|                                                  _|_|_|                _|                
#     _|      _|_|    _|  _|_|  _|  _|_|    _|_|    _|  _|_|  _|    _|  _|    _|  _|_|_|_|    _|_|    
#     _|    _|_|_|_|  _|_|      _|_|      _|    _|  _|_|      _|_|_|    _|    _|    _|      _|_|_|_|  
#     _|    _|        _|        _|        _|    _|  _|        _|    _|  _|    _|    _|      _|        
#     _|      _|_|_|  _|        _|          _|_|    _|        _|_|_|      _|_|_|      _|_|    _|_|_|  
#                                                                             _|                      
#                                                                         _|_|                        
# April 5 2012
#
# Simple script for starting a piratebox on a laptop (eeePC specifically)
#
# By Cale "TerrorByte" Black 
#
# Credit for the original piratebox goes to David Darts
#
# Credit for the wonderful scripts goes to Matthias Strubel
#  
###########################################################################################################################
###########Version 0.6.9###################################################################################################
# Fixed a bug that wouldn't allow you to view download folder or chat
# In version b got rid of the sudo su that caused a loop
###########################################################################################################################
PS3='Please enter your choice: '
options=("Quick install for Debian based systems" "Start PirateBox" "Stop PirateBox" "Just Download the Scripts" "Edit piratebox.conf" "Edit hostapd.conf (SSID, Channel, Driver, etc)" "Quit")
###########################################################################################################################
#Final menu will be:
#1) Install PirateBox (only run one time)
#2) Start PirateBox
#3) Stop PirateBox
#4) Manage Files
#5) Download scripts only
#6) Configure
#7) Exit 
###########################################################################################################################
#Add a splash screen with ASCII PirateBox logo
###########################################################################################################################
select opt in "${options[@]}"

do
    case $opt in
"Quick install for Debian based systems")
sudo wget -P /tmp/ http://piratebox.aod-rpg.de/dokuwiki/lib/exe/fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
cd /tmp/
cp -i fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz piratebox-0.3.3-scripts-1.9.tar.gz
rm fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
tar xzvf piratebox*.tar.gz
cd /tmp/piratebox
cp -rv piratebox /opt
ln -s /opt/piratebox/init.d/piratebox /etc/init.d/piratebox
rm /opt/piratebox/share & ln -s /mountpoint /opt/piratebox/share 
chmod 777 /opt/piratebox/chat/cgi-bin/data.pso
# Add these to lines to /etc/hosts
#sudo sed "192.168.77.1  piratebox.lan i\ 192.168.77.1  
#Bash denies access to /etc/hosts
#piratebox" > /etc/hosts
echo "192.168.77.1  piratebox.lan">>/etc/hosts
echo "192.168.77.1  piratebox">>/etc/hosts
service network-manager stop
killall dhclient
killall dnsmasq
/etc/init.d/piratebox start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;

"Start PirateBox")
/etc/init.d/piratebox start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;

"Stop PirateBox")
/etc/init.d/piratebox stop
service network-manager start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;
###########################################################################################################################
#Add manage files (opens PB folder in nautilaus)
###########################################################################################################################
"Just Download the Scripts")
wget -P /tmp/ http://piratebox.aod-rpg.de/dokuwiki/lib/exe/fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
cd /tmp/
cp -i fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz piratebox-0.3.3-scripts-1.9.tar.gz
rm fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
echo ""
echo "Files saved in /tmp"
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;
###########################################################################################################################
#Create a Config option and include this option and the one below
#Add quick configuration options:
#	- Change SSID
#	- Change Channel
#	- Change PirateBox upload / download directory
#	- Clear PirateBox upload / download directory
###########################################################################################################################
"Edit piratebox.conf")
nano /opt/piratebox/conf/piratebox.conf
clear
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;

"Edit hostapd.conf (SSID, Channel, Driver, etc)")
nano /opt/piratebox/conf/hostapd.conf
clear
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Edit piratebox.conf"
echo "6) Edit hostapd.conf (SSID, Channel, Driver, etc)"
echo "7) Quit"
;;
###########################################################################################################################
#View Upload folder
#Possible to do real time updates?
#Interface for managing files (may wait until GUI)
###########################################################################################################################
#Add Debugging for:
#No package for dnsmasq and hostapd (Older versions 10.04 and below do not have universe debs active by default, see comments in option 1)
#No network access after taking PirateBox down (use sudo service network-manager stop and than sudo service network-manager start
#No access to chat or viewing uploaded folder (Copy from /opt/piratebox/conf/hosts to /etc/hosts)
#Debug Manual from http://piratebox.aod-rpg.de/dokuwiki/doku.php?id=script-package_for_debian_based_systemes&DokuWiki=93bea71d696f0054de696f11d8acc0e0
###########################################################################################################################
#Add ManPages / Manual
#Quick Manual
#History of PirateBox
#Debug Manual from above
#Help Develope? page
#Art
###########################################################################################################################

"Quit")
clear
break
;;
*) echo invalid option;;

esac
done
###########################################################################################################################
#GUI
#Make out of wxPython
#Or Java later on for multiple OS?
###########################################################################################################################
#LiveCD fork
#PirateBox Manager LiveCD version
#Disables install option (will be installed by default)
###########################################################################################################################
