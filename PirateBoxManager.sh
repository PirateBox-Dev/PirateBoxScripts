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
###########Version 0.7.0###################################################################################################
# Fixed not being able to execute because of a token (Sorry about that :(   )
# Added Splash Screen
# Cleaned up Dev notes
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
#Add manage files (opens PB folder in nautilaus)
###########################################################################################################################
#Create a Config option and include this option and the one below
#Add quick configuration options:
#	- Change SSID
#	- Change Channel
#	- Change PirateBox upload / download directory
#	- Clear PirateBox upload / download directory
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
#GUI
#Make out of wxPython
#Or Java later on for multiple OS?
###########################################################################################################################
#LiveCD fork
#PirateBox Manager LiveCD version
#Disables install option (will be installed by default)
###########################################################################################################################

echo "
__________.__                 __         __________  .____    ____.         
\______   \__|____________  _/  |_   ____\______   \ |   _|  |_   | ___  ___
 |     ___/  |\_  __ \__  \ \   __\_/ __ \|    |  _/ |  |      |  | \  \/  /
 |    |   |  | |  | \// __ \_|  |  \  ___/|    |   \ |  |      |  |  >    < 
 |____|   |__| |__|  (____  /|__|   \___  >______  / |  |_    _|  | /__/\_ |
 	 	          \/            \/       \/  |____|  |____|       \/

             
"                                   

PS3='Please enter your choice: '
options=("Quick install for Debian based systems" "Start PirateBox" "Stop PirateBox" "Just Download the Scripts" "Configure" "Quit")

select opt in "${options[@]}"
do
    case $opt in
"Quick install for Debian based systems")
sudo wget -P /tmp/ http://piratebox.aod-rpg.de/dokuwiki/lib/exe/fetch.php?media=piratebox-scripts_0.4.tar.gz
cd /tmp/
sudo cp -i fetch.php?media=piratebox-scripts_0.4.tar.gz piratebox-scripts_0.4.tar.gz
sudo rm fetch.php?media=piratebox-scripts_0.4.tar.gz
sudo tar xzvf piratebox*.tar.gz
cd /tmp/piratebox
sudo cp -rv piratebox /opt
sudo ln -s /opt/piratebox/init.d/piratebox /etc/init.d/piratebox 
sudo chmod 777 /opt/piratebox/chat/cgi-bin/data.pso
echo "192.168.77.1  piratebox.lan">>/etc/hosts
echo "192.168.77.1  piratebox">>/etc/hosts
sudo service network-manager stop
sudo killall dhclient
sudo killall dnsmasq
sudo /etc/init.d/piratebox start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Configure"
echo "6) Quit"
;;

"Start PirateBox")
sudo /etc/init.d/piratebox start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Configure"
echo "6) Quit"
;;

"Stop PirateBox")
sudo /etc/init.d/piratebox stop
sudo service network-manager start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Configure"
echo "6) Quit"
;;

"Just Download the Scripts")
sudo wget -P /tmp/ http://piratebox.aod-rpg.de/dokuwiki/lib/exe/fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
cd /tmp/
sudo cp -i fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz piratebox-0.3.3-scripts-1.9.tar.gz
sudo rm fetch.php?media=piratebox-0.3.3-scripts-1.9.tar.gz
echo "Files saved in /tmp"
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Just Download the Scripts"
echo "5) Configure"
echo "6) Quit"
;;
"Quit")
break
;;

"Configure")
echo ""
PS3='Please enter your choice: '
config=("Edit piratebox.conf" "Edit hostapd.conf" "Quit")
select config in "${config[@]}"
do
    case $config in
"Edit piratebox.conf")
nano /opt/piratebox/conf/piratebox.conf
;;

"Edit hostapd.conf")
nano /opt/piratebox/conf/hostapd.conf
;;
"Quit")
break
;;
*) echo invalid option;;
esac
done
break
;;
*) echo invalid option;;

esac
done
