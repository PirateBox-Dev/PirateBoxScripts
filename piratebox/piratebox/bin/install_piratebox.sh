#!/bin/sh

#Piratebox installer Script v.001
#  Matthias Strubel 

cp_src () {
   source_path=$1
   dest_path=$2

#   filelist=( .BACK.TO.MENU.htm  .READ.ME.htm favicon.ico piratebox-logo-small.png piratebox-logo.png )

   cp -v $source_path/.BACK.TO.MENU.htm   $dest_path/
   cp -v $source_path/.READ.ME.htm        $dest_path/
   cp -v $source_path/favicon.ico         $dest_path/
   cp -v $source_path/piratebox-logo-small.png  $dest_path/
   cp -v $source_path/piratebox-logo.png  $dest_path/

}


if [ -z  $1 ] || [ -z $2 ]; then
  echo "Usage install_piratebox my_config <part>"
  echo "   Parts: "
  echo "       prepShare      : copy over needed Files from src to share "
  echo "       pyForum        : Installs basic python forum; set up piratebox.conf yourself"
  echo "       init_openwrt   : Initializes the package on openwrt routers"
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
#  cp -v $pb_pbmount/src/* "$pb_share"
#  cp -v $pb_pbmount/src/.* $pb_share
  cp_src  $pb_pbmount/src $pb_share
  touch "$pb_pbmount/conf/init_done"
  # Copy Removed, File is included in lib folder.. 
  #cp /usr/share/piratebox/CGIHTTPServer.py $pb_pbmount/chat
  rm -r $pb_pbmount/share 
  ln -sf $pb_share $pb_pbmount/share
  chmod a+rw $CHATFOLDER/cgi-bin/data.pso
fi

if [ $2 = 'prepShare' ] ; then
  cp_src /opt/piratebox/src $FOLDER
fi

if [ $2 = 'pyForum' ] ; then
    cp -v /opt/piratebox/src/forest.py  $CHATFOLDER/cgi-bin
    cp -v /opt/piratebox/src/forest.css $CHATFOLDER/
    mkdir -p /opt/piratebox/forumspace
    chmod a+rw -R  /opt/piratebox/forumspace
    echo "Copied the file. Now edit conf/piratebox.conf and uncomment #FORUM_LINK_HTML " 
fi
