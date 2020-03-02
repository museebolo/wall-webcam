#!/usr/bin/env bash
# Project: Webcam
# File: print_webcam.py
# Version: 0.1
# Create by: Rom1 <romain@museebolo.ch> - Musée Bolo - https://www.museebolo.ch
# Date: 10/02/2020
# Licence: GNU GENERAL PUBLIC LICENSE v3
# Language: Bash
# Description: Affichage des webcam dans le mur.

config_f="config.sh"

usage()
{
        echo "Usage: $(basename $0)"
}

send_t_message()
{
        mess="${1}"
        echo "Envoyer le message sur Telegram: ${mess}"
        t_mess="https://api.telegram.org"
        t_mess="${t_mess}/${T_BOT_ID}"
	t_mess="${t_mess}/sendMessage?chat_id=${T_CHAN_ID}&text=${mess}"
        curl "${t_mess}"
}

create_image()
{
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
			#send_t_message "Webcam: Problème avec l'image ${f}"
		done
	fi

	for i in $(seq 0 8)
	do 
		convert ${TMP}/$i.jpg -resize 400x300\! ${TMP}/src-$i.jpg
	done

	montage ${TMP}/src-*.jpg -background "#ffffff" -border 0 -geometry +3+3 ${TMP}/webcams.jpg
}

# Charge la configuration
#if [[ ! -a ${config_f} ]]
if [ ! -f ${config_f} ]
then
	echo "Il manque le fichier de configuration: ${config_f}"
	usage
	exit 1
fi
source ${config_f}

while true
do
	create_image
	feh --bg-center ${TMP}/webcams.jpg
	sleep ${REFRESH_DELAY}
done
