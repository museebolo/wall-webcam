#!/bin/bash
num=0
for i in $(cat /tmp/imglist)
do
  wget -O "/tmp/$num.jpg" --tries=1 --timeout=4 "$i"
  num=$(($num+1))
done
