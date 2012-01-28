#!/usr/bin/perl -wT

use strict;
use CGI;
use CGI::Carp qw ( fatalsToBrowser );
use File::Basename;

my $query = new CGI;


my $template= {};

# Global Values ( later filled out of config)
my $global = {};

$global->{'message'} = "
<b>1.</b> Learn more about the project <a href=\"/.READ.ME.htm\" target=\"_parent\"><b>here</b></a>.
<p><b>2.</b> Click button below to begin sharing.</p>
<b>3.</b> Browse and download files <a href=\"/unsorted\" target=\"_parent\"><b>here</b></a>.<br /> <br />";

$global->{'htmlpicture'} = "<img src='/piratebox-logo-small.png' alt='piratebox-logo' />";
$global->{'linkurl'} = "";
$global->{'upload_dir'} = "/opt/piratebox/share/unsorted";

### <------------- Language Section ----------------->

# Hash-Table with current language setting
my $curr_lang  ;

# all known lang
my $lang;

 $lang->{'de'}->{"maintitle"} 		= "Datei Senden";
 $lang->{'de'}->{"submit"}    		= "Senden" ;
 $lang->{'de'}->{"sending"}  		= "Sendet" ;
 $lang->{'de'}->{"successtitle"} 	= "Datei empfangen";
 $lang->{'de'}->{"received"}  		= "Datei empfangen!";
 $lang->{'de'}->{"another"}   		= "Weitere Datei senden";
 $lang->{'de'}->{"errortitle"}  	= "Fehler" ;
 $lang->{'de'}->{"problem"}  		= "Ein Fehler ist aufgetreten!";
 $lang->{'de'}->{"retry"}  		= "Wiederholen";
 $lang->{'de'}->{"discover"} 		= "Internet-Adresse dieser Seite feststellen" ;

 $lang->{'en'}->{"maintitle"}           = "Send a file";
 $lang->{'en'}->{"submit"}              = "Send" ;
 $lang->{'en'}->{"sending"}             = "Sending" ;
 $lang->{'en'}->{"successtitle"}        = "File received";
 $lang->{'en'}->{"received"}            = "File received !";
 $lang->{'en'}->{"another"}             = "Send another file.";
 $lang->{'en'}->{"errortitle"}          = "Problem" ;
 $lang->{'en'}->{"problem"}             = "There has been a problem !";
 $lang->{'en'}->{"retry"}               = "Retry.";
 $lang->{'en'}->{"discover"}            = "Discover the address of this page" ;



# TODO ; more
$curr_lang = $lang->{'en'};


### <--------- Template Section --------- >


sub template_style () {
  my $var = '<!-- Style template Start --> 
<LINK rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<style type="text/css">
<!--
* {margin: 0; padding: 0;}
body {text-align: left; font-size: 1.0em; font-family: sans-serif;}
.box {padding-top:10px; padding-bottom:0px;}
#message {text-align: left; width: 310px;}
#sending {display: none;}
#wrapform {height: 40px;}
#progress {display: inline;  border-collapse: separate; empty-cells: show;
           border-spacing: 10px 0; padding: 0; vertical-align: bottom;}
#progress td {height: 10px; width: 13px; background-color: #eee;
              border: 1px solid #aaa; padding: 0px;}
--></style>
<!-- Style Template Stop -->
';
   return $var;
}


sub template_userinfo () {

  my $var = ' 
<div class="box">'. $global->{'htmlpicture'}. '</div>
<div id="message" class="box"> '. $global->{'message'} .'</div>
';

   return $var;
}

sub template_main () {
   my $var = '  <!-- Main template Start -->
<html><head><title>'. $curr_lang->{'maintitle'} .'</title>';
   $var .= template_style() ;
   $var .= ' <script language="JavaScript">
function swap() {
   document.getElementById("form").style.display = "none";
   document.getElementById("sending").style.display = "block";
   update();
}
ncell = 4;
curcell = 0;
function update() {
   setTimeout(update, 300);
   e = document.getElementById("cell"+curcell);
   e.style.backgroundColor = "#eee";
   curcell = (curcell+1) % ncell
   e = document.getElementById("cell"+curcell);
   e.style.backgroundColor = "#aaa";
}
function onunload() {
   document.getElementById("form").style.display = "block";
   document.getElementById("sending").style.display = "none";
}
</script></head><body> <center>' ;
#  $var .=  $global->{'linkurl'} ;
  $var .=  template_userinfo() ; 
  $var .=' <div id="wrap">  <div id="wrapform">
    <div id="form">
      <form method="post" enctype="multipart/form-data" action="droopy.pl">
        <input type="hidden" name="action" value="do_upload" />
        <input name="upfile" type="file">
        <input value="';
  $var .= $curr_lang->{'submit'} ;
  $var .= '" onclick="swap()" type="submit">
    </div>
    <div id="sending">'. $curr_lang->{'sending'} .' &nbsp;
      <table id="progress"><tr>
        <td id="cell0"/><td id="cell1"/><td id="cell2"/><td id="cell3"/>
      </tr></table>
    </div>
  </div>';

  $var .=  template_piratebox_board () .'

</center>
</body> </html>
<!-- Main Template end-->
';

return $var;
}

sub template_success () {

  my $var  = '<!-- SUCCESS template Start -->
<html>
<head><title> '. 
$curr_lang->{"successtitle"} . '</title> 
'.  template_style()   .'
</head>
<body>
<center>
'. template_userinfo() .'
<div id="wrap">
  <div id="wrapform">
 '.    $curr_lang->{"received"} .'
   <a href="droopy.pl"> '. $curr_lang->{'another'}  .'</a>
  </div>
' .template_piratebox_board ().' 
</div></center>
</body>
</html>
<!-- SUCCESS template END -->';
  return $var;
}


sub template_error () { 
 my $var = ' <!-- ERROR template Start -->
<html>
<head><title> '. $curr_lang->{"errortitle"} .'</title>'
.  template_style()   .
'</head>
<body><center>
'. template_userinfo() .'

  <div id="wrap">
    <div id="wrapform">
   '.   $curr_lang->{'problem'}    .'
      <a href="/"> '.  $curr_lang->{"retry"} .' </a>
    </div>
</div>

'. template_piratebox_board () .'
</center>
</body>
</html>
 <!-- ERROR template END -->';
return $var;
}


sub template_piratebox_board () {
  my $var = " <a href='/board/kareha.pl' target='_parent'>Feel free for an open discussion here</a>";

  return $var;
 
}



# linkurltmpl = '''<div id="linkurl">
# <a href="http://stackp.online.fr/droopy-ip.php?port=%(port)d"> %(discover)s
# </a></div>''

### <----- More Functions ------>

sub do_upload () {
  my $safe_filename_characters = "a-zA-Z0-9_.-";  

  my $filename = $query->param("upfile");
  if ( !$filename ) {
    print template_error ();
  }
  
  my ( $name, $path, $extension ) = fileparse ( $filename, '\..*' );
  $filename = $name . $extension;
 
  $filename =~ tr/ /_/;
  $filename =~ s/[^$safe_filename_characters]//g;

  if ( $filename =~ /^([$safe_filename_characters]+)$/ )
  {  
  # Not allow index.* names
     if ( $filename =~ /index\.\w+/ ) {
        die "Not allowed to upload index-files";
     } else { 
        $filename = $1;
     }
  } else  {
    die "Filename contains invalid characters";
  }

  my $upload_filehandle = $query->upload("upfile");

  open ( UPLOADFILE, ">".$global->{'upload_dir'}."/tmp_".$filename ) or die "$!";
  binmode UPLOADFILE;

  while ( <$upload_filehandle> )
  {
     print UPLOADFILE;
  }
  close UPLOADFILE;
 
  # Delete existing file
  unlink ( $global->{'upload_dir'}."/$filename" );
  # Rename after finished upload
  rename ($global->{'upload_dir'}."/tmp_".$filename , $global->{'upload_dir'}."/$filename");   

  print  template_success();

}


### <-------- Controller Part ---------------->


print $query->header ( );

if ( $query->param("action") ) {
  if ( $query->param("action") eq 'do_upload' ) {
     do_upload ();
  }
} else  {
 print template_main();
}


