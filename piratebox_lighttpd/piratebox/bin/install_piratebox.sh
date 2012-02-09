#!/bin/sh
## PirateBox installer script  v.01
##  created by Matthias Strubel   2011-08-04
##


# Load configfile

if [ -z  $1 ] || [ -z $2 ]; then 
  echo "Usage install_piratebox my_config <part>"
  exit 1
fi


if [ !  -f $1 ] ; then 
  echo "Config-File $1 not found..." 
  exit 1 
fi

#Load config
. $1 


#Router Packages
if [ $2 = 'openwrt' ] ; then

################# Divide into with or without piratebox    (* base package)
  # lighttpd   			*
  # lighttpd-mod-accesslog	*
  # lighttpd-mod-cgi		*
  # lighttpd-mod-redirect	*
  # lighttpd-mod-compress	*
  # lighttpd-mod-rewrite	*
  # dnsmasq			*
  # perl 			*
  # perlbase-base		*
  # perlbase-bytes
  # perlbase-config
  # perlbase-cgi 		*
  # perlbase-data
  # perlbase-db-file
  # perlbase-digest
  # perlbase-encode
  # perlbase-encoding		
  # perlbase-essential		*
  # perlbase-fcntl
  # perlbase-file		*
  # perlbase-gdbm-file
  # perlbase-integer
  # perlbase-socket
  # perlbase-unicode
  # perlbase-utf8
  # perlbase-xsloader
fi


if [ $2 = 'part2' ] ; then
#Create directories 
   mkdir -p $PIRATEBOX_FOLDER/share/unsorted
   mkdir -p $PIRATEBOX_FOLDER/share/board
   mkdir -p $PIRATEBOX_FOLDER/share/tmp
   mkdir -p $PIRATEBOX_FOLDER/tmp

#Set permissions
   chown $LIGHTTPD_USER:$LIGHTTPD_GROUP  $PIRATEBOX_FOLDER/share -R
   chmod  u+rw $PIRATEBOX_FOLDER/share
   chown $LIGHTTPD_USER:$LIGHTTPD_GROUP  $PIRATEBOX_FOLDER/www -R
   chmod u+x $PIRATEBOX_FOLDER/www/cgi-bin/* 
   chown $LIGHTTPD_USER:$LIGHTTPD_GROUP  $PIRATEBOX_FOLDER/tmp
   chown $LIGHTTPD_USER:$LIGHTTPD_GROUP  $PIRATEBOX_FOLDER/tmp -R

#Copy over the index.html for redirect to Droopy-Landing page
   cp $PIRATEBOX_FOLDER/www/index.html $PIRATEBOX_FOLDER/share

#Install a small script, that the link on the main page still works
   if  [ !  -f $PIRATEBOX_FOLDER/share/board/kareha.pl ] ; then  
      cp $PIRATEBOX_FOLDER/src/kareha.pl $PIRATEBOX_FOLDER/share/board
   fi
   
   ln -s $PIRATEBOX_FOLDER/share/board $PIRATEBOX_FOLDER/www/board
   ln -s $PIRATEBOX_FOLDER/share/unsorted $PIRATEBOX_FOLDER/www/unsorted
fi 

#Install the image-board
if [ $2 = 'imageboard' ] ; then
    cd  $PIRATEBOX_FOLDER/share/board
    cp -R  mode_image/* ./ 
    cp  $PIRATEBOX_FOLDER/src/kareha_img_config.pl $PIRATEBOX_FOLDER/share/board/config.pl
    chown -R $LIGHTTPD_USER:$LIGHTTPD_GROUP  $PIRATEBOX_FOLDER/share/board 
    #Install filetype thumbnails
    mv $PIRATEBOX_FOLDER/share/board/extras/icons  $PIRATEBOX_FOLDER/share/board/
fi

