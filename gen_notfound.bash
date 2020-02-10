#!/bin/bash
convert -size 400x300 xc:white -font /usr/share/fonts/truetype/freefont/FreeMono.ttf -pointsize 72 -fill black -stroke black -strokewidth 0 -draw "text 70,90 'Webcam'" -draw "text 50,200 'offline'" -stroke none notfound.jpg
