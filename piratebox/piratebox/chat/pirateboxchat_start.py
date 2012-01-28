#!/usr/bin/python
#python server (968)

webdir = '.' #where html and cgi-bin files live
port = 8002    #use http://localhost/

import os, sys
from BaseHTTPServer import HTTPServer
from CGIHTTPServer import CGIHTTPRequestHandler

if len(sys.argv) > 1: webdir = sys.argv[1]
if len(sys.argv) > 2: port = int(sts.argv[2])
print 'webdir: "%s", port %s' % (webdir, port)

#windows hack, os.environ not propagated
if sys.platform[:3] == 'win':
    CGIHTTPRequestHandler.have_popen2 = False
    CGIHTTPRequestHandler.have_popen3 = False #emulate path after fork
    sys.path.append('cgi-bin')                #else only adds my dir

os.chdir(webdir)                              #run in HTML root dir
srvraddr = ("", port)                         #my hostname, port number
srvrobj = HTTPServer(srvraddr, CGIHTTPRequestHandler)
srvrobj.serve_forever()                       #serve clients till exit
