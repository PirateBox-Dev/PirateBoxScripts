PyShoutOut
==========

By J-Tech (http://joeyjwc.x3fusion.com).

Version 1.0

Installation
------------
(Excerpt from PSO manual (http://joeyjwc.x3fusion.com/webdev/pso/manual/index.html).

1.  Unzip the downloaded file.  You should see a folder labeled pyshoutout and a file named psoinstall.py.

2.  Upload the folder and the file to your /cgi-bin/ directory.  Make sure that you upload it in ASCII format.

3.  Using your FTP program or other, CHMOD (set permissions) of the psoinstall.py file to 755, that is User: Read, Write, Execute; Group: Read, Execute; World: Read, Execute.

4.  Go to http://[yourdomain]/cgi-bin/psoinstall.py to setup the script.

5.  (Optional) Edit style.css to reflect how you want the font, etc.

6.  Paste the following code into an HTML Page:

<iframe name="psoread" src="/cgi-bin/pyshoutout/psoread.py" width="100%" height="370">
Your browser does not support inline frames or is currently configured not to display inline frames.</iframe></p>
<script language="javascript">
<!--
function reset() {
self.document.psowrte.data.value="";
self.document.psowrte.data.focus();
}
-->
</script>
<form method="POST" action="/cgi-bin/pyshoutout/psowrte.py" target="psoread" name="psowrte" onsubmit="setTimeout('reset()',10)">
<p align="center">
<b>Name:</b><input type="text" name="name" size="10">&nbsp;&nbsp; <b>Message:</b><input type="text" name="data" size="20">&nbsp;&nbsp;
<input type="submit" value="Say" name="submit"><br>
<b>Color:</b> Default<input type="radio" value="def" name="color" checked> |
<font color="#0000FF">Blue</font><input type="radio" value="blue" name="color"> 
| <font color="#008000">Green</font><input type="radio" value="green" name="color"> 
| <font color="#FF8040">Orange</font><input type="radio" value="orange" name="color"> 
| <font color="#FF0000">Red</font><input type="radio" value="red" name="color"></p>
</form>

7.  You can now delete /cgi-bin/psoinstall.py.


EULA
----
I'm not very good at these, so I'll make it short and sweet.

LIABILITY:
J-Tech is in NO WAY WHATSOEVER liable for anything, good or bad, that may happen to your website, server, host, domain, or anything else upon installation and use of the PyShoutOut system.  In fact, J-Tech is not liable at all for anything that ever occurs.  THE USE OF THIS SOFTWARE IS YOUR CHOICE AND YOUR CHOICE ALONE.  IT IS QUITE POSSIBLE THAT THERE IS ONE OR MORE BUGS IN THE SOFTWARE, BUT THEY WILL BE ADDRESSED BY J-TECH IN FUTURE VERSIONS.

DISTRIBUTING, MODIFYING, ETC.:
This software may be distributed to others SO LONG AS the readme.txt file remains unaltered in ANY way.  Because this is readily available source code, J-Tech will not try to stop you in any way from modifying it.  However, you must include a seperate readme file in that case.  This file will remain as "readme.txt" under all circumstances.  J-Tech kindly asks that you give them all credit where it is due.

In English:
J-Tech isn't liable for what happens when you install this program.  There might be one or more bugs in the software, so don't expect anything to be perfect.  Don't modify this file or rename it.  If you plan to modify the program, please be careful and give J-Tech credit where it is due.


Conclusion
----------
On behalf of J-Tech, we hope that you enjoy this program very much.  Good luck and happy web developing!


J-Tech
http://joeyjwc.x3fusion.com/
http://joeyjwc.x3fusion.com/webdev/