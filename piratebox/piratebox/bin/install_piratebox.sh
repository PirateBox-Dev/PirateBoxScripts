#!/bin/sh

#Piratebox installer Script v.001
#  Matthias Strubel 


if [ -z  $1 ] || [ -z $2 ]; then
  echo "Usage install_piratebox my_config <part>"
  echo "   Parts: "
  echo "       pyForum        : Installs basic python forum; set up piratebox.conf yourself"
  echo "       init_openwrt   : Initializes the package on openwrt routers"
  echo "       part2          : sets Permissions and links correctly"
  exit 1
fi

if [ !  -f $1 ] ; then
  echo "Config-File $1 not found..."
  exit 1
fi

. $1

if [ $2 = 'init_openwrt' ] ; then
  #Load openwrt-common config and procedures file!
  . /etc/piratebox.common
  cp -v $pb_pbmount/src/* "$pb_share"
  cp -v $pb_pbmount/src/.* $pb_share
  touch "$pb_pbmount/conf/init_done"
  # Copy Removed, File is included in lib folder.. 
  #cp /usr/share/piratebox/CGIHTTPServer.py $pb_pbmount/chat
  rm -r $pb_pbmount/share 
  ln -sf $pb_share $pb_pbmount/share
  chmod a+rw $CHATFOLDER/cgi-bin/data.pso
fi

if [ $2 = 'pyForum' ] ; then
    cp -v /opt/piratebox/src/forest.py  $CHATFOLDER/cgi-bin
    cp -v /opt/piratebox/src/forest.css $CHATFOLDER/
    mkdir -p /opt/piratebox/forumspace
    chmod a+rw -R  /opt/piratebox/forumspace
fi
  
  
