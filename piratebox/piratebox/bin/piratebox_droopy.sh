#!/bin/bash

. $1

/opt/piratebox/bin/droopy -d $FOLDER -p $IMAGE -m "$TEXT"  -c "$DROOPY_INCLUDE" 
