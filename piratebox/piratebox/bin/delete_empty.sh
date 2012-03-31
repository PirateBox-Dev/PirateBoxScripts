#!/bin/sh
# Deletes 0 Byte Files


#Field Seperator
IFS='
'

cd $1
array=(`ls -1 `)

len=${#array[*]}

i=0
while [ $i -lt $len ]; do
  if [ ! -s ${array[$i]} ] ; then
    echo "Deleting 0 Byte file ${array[$i]}"
    rm ${array[$i]}
  fi
  let i++
done


