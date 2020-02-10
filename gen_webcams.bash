#!/bin/bash

if [ $(find /tmp -size 0b -name "*.jpg"|wc -l) != "0" ]
then
 for f in $(find /tmp -size 0b -name "*.jpg") 
 do
  cp notfound.jpg $f
 done
fi

for i in $(seq 0 8);do convert /tmp/$i.jpg -resize 400x300\! /tmp/src-$i.jpg;done
montage /tmp/src-*.jpg -background "#ffffff" -border 0 -geometry +3+3 /tmp/webcams.jpg
