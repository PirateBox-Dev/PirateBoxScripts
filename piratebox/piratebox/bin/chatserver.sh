#!/bin/bash

cd $1
#using exec replaces the current running session, which provides the correct pid on the start-stop-daemon
exec python pirateboxchat_start.py 


