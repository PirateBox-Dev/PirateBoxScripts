## Piratebox for laptop (eeePc) script collection   WITH LIGHTTPD
##   created by Matthias Strubel (matthias.strubel@aod-rpg.de)  2011-03-19
##   licenced by gpl ;; please feel for improvements or feedback :)
##  Changes:
##    2011-03-19  First concept release with shoutbox left in python and droopy in perl
##
 
What to do? / Install
---------------------
  > Install debian
  > Install following Packages:
     - Python
     #  apt-get install python
     - Perl  
     #  apt-get install perl
     - lighttpd
     #  apt-get install lighttpd
     - if needed : hostapn and/or dnsmasq
     # apt-get install hostapn
     # apt-get install dnsmasq

  > configure your share-folder (where should the uploaded file put to?)
  >   in my case, I used /opt/piratebox/share

  > copy over the piratebox folder into /opt/ (as root)
    # sudo mkdir /opt 
    # sudo cp -rv piratebox /opt 
  > create a symlink /opt/piratebox/init.d/piratebox /etc/init.d/
     # sudo ln -s /opt/piratebox/init.d/piratebox /etc/init.d/piratebox  
  > add piratebox to you runlevel (optional)
    # sudo  update-rc.d piratebox defaults 
  > create a link from your share-device to /opt/piratebox/share
    # sudo ln -s /mnt/usbstick /opt/piratebox/share
  > define your personall options in
    # /opt/piratebox/conf/piratebox.conf        # Start which services, IPs etc
    # /opt/piratebox/conf/hostapd.conf          # Some stuff about beeing an APN 

I created
/opt/piratebox/bin    - Binarys and Scripts
/opt/piratebox/conf   - Piratebox related configs (seperated from the normal system-configs!)
/opt/piratebox/share  - Mountpoint (with the first start of piratebox, the correct permissions will be set)
/opt/piratebox/init.d - the init-script (later more?)
/opt/piratebox/www    - Webfolder with cgi-scripts and static html pages
/opt/piratebox/tmp    - Folder with the error-log


My cgi-droopy script
----------------------
Its based on the original droopy script with the modifications by David Darts. It doesn't support language switching support
yet.


Chatbox/Shoutbox-Integration
-------------------
The Shoutbox is by J-Tech (http://joeyjwc.x3fusion.com). He uses a fix path for the datafile. Because of pointing this path to the /chat folder (yes... in the root directory ),
I changed this path in the chat/cgi-bin/pso*.py scripts to /opt/piratebox/chat/cgi-bin/.
If you plan to put your files somewhere else, you need to change the path in the mentioned scripts.


Change directory?
-------------------
If you decide not to run piratebox under /opt you have to change following scripts:
piratebox/conf/piratebox.conf
piratebox/init.d/piratebox
piratebox/conf/lighttpd/lighttpd.conf


Seperate Runlevel
-----------------
I'm using the piratebox on another runlevel, because I don't want to use it on daily work. So do not use the above update-rc.d command if you don't intend to start it always.
If you want to use it on another runlevel you can use
 #  update-rc.d piratebox enable 4
and disable other services, you don't need
 i.e.  # update-rc.d acpid disable 4
These examples are for debian based distributions.


What will bring the future?
---------------------------
My imagination is to create a boot-up entry in grub, for booting the piratebox-setup or as a normal netbook. 
I want realize this with an extra runlevel configurated for the piratebox. In fact you have to stop special options of acpi to not go to standby in "piratebox"-mode.
For sure, I have some other ideas for creating flexible crypted datasets ;)
Maybe I'll create a script for changing the hosts file taking account of the settings from the piratebox.conf - we'll see ;)

Thank you for trying or using my scripts :)

  
