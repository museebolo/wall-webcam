#!/bin/bash

URL="https://www.abcm.ch/webcam/url_list.txt"
DEST=/tmp/imglist
DEST_TEMP=/tmp/imglist.dl

wget --no-check-certificate -O "$DEST_TEMP" "$URL"
STATUS=$?
if [ $STATUS -ne 0 ]; then
  exit 1
else
  rm "$DEST"
  mv "$DEST_TEMP" "$DEST"
fi
