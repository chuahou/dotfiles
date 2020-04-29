#!/bin/bash

VALUE_COLOR=${color:-$(xrescat i3xrocks.value.color "#D8DEE9")}
VALUE_FONT=${font:-$(xrescat i3xrocks.value.font "Source Code Pro Medium 13")}
LABEL_ICON=${label_icon:-$(xrescat i3xrocks.label.wired )}
LABEL_COLOR=${label_color:-$(xrescat i3xrocks.label.color "#7B8394")}

SERVER=$(nordvpn status | grep "Current server")

if [ ! -z "$button" ]
then
	if [ -z "$SERVER" ]
	then
		nordvpn c &> /dev/null
	else
		nordvpn d &> /dev/null
	fi
fi

SERVER=$(nordvpn status | grep "Current server" | gawk '{print $3}' | cut -d"." -f1)

if [ -z "$SERVER" ]
then
	SERVER="---"
fi

echo "<span color=\"${LABEL_COLOR}\">${LABEL_ICON}</span><span font_desc=\"${VALUE_FONT}\" color=\"${VALUE_COLOR}\"> $SERVER</span>" # full text
