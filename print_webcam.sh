#!/usr/bin/env bash
# Project: Webcam
# File: print_webcam.py
# Version: 0.1
# Create by: Rom1 <romain@museebolo.ch> - Musée Bolo - https://www.museebolo.ch
# Date: 10/02/2020
# Licence: GNU GENERAL PUBLIC LICENSE v3
# Language: Python 3
# Description: Affichage des webcam dans le mur.

URL="https://www.abcm.ch/webcam/url_list.txt"
TMP="tmp"
DEST=${TMP}/imglist
DEST_TEMP=${TMP}/imglist.dl

wget --no-check-certificate -O "$DEST_TEMP" "$URL"
STATUS=$?
if [ $STATUS -ne 0 ]; then
        exit 1
else
        rm "$DEST"
        mv "$DEST_TEMP" "$DEST"
fi


num=0
for i in $(cat ${TMP}/imglist)
do
        wget -O "${TMP}/$num.jpg" --tries=1 --timeout=4 "$i"
        num=$(($num+1))
done


if [ $(find ${TMP} -size 0b -name "*.jpg"|wc -l) != "0" ]
then
        for f in $(find ${TMP} -size 0b -name "*.jpg") 
        do
                cp notfound.jpg $f
        done
fi

for i in $(seq 0 8)
do 
        convert ${TMP}/$i.jpg -resize 400x300\! ${TMP}/src-$i.jpg
done

montage ${TMP}/src-*.jpg -background "#ffffff" -border 0 -geometry +3+3 ${TMP}/webcams.jpg

#feh -F /tmp/webcams.jpg
