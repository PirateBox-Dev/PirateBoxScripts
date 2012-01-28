#!/bin/bash

cd $1
#python -m SimpleHTTPServer 8001
#using exec replaces the current running session, which provides the correct pid on the start-stop-daemon
# old Version exec python -m SimpleHTTPServer 8001
exec python  $2/bin/webserver.py 8001

