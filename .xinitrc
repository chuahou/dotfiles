#!/usr/bin/env bash

# load Xresources
xrdb -merge $HOME/.Xresources

# force full composition pipeline for nvidia to prevent tearing
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"

# check if external monitor connected to HDMI-0
# this specific setup for Dell G7 and Prism+ W240
if [ $(xrandr -q | grep -c "HDMI-0 connected") -gt 0 ]; then
	# turn off eDP-1-1 and connect only to HDMI-0
	xrandr --output HDMI-0 --mode 1920x1080 --rate 75 --primary \
		--output eDP-1-1 --off
else
	xrandr --output eDP-1-1 --mode 1920x1080 --rate 60 --primary \
		--output HDMI-0 --off
fi

# disable mouse acceleration
xset mouse 0 0
xinput set-prop "Logitech G103 Prodigy Gaming Mouse" \
	"libinput Accel Profile Enabled" 0 1

# run i3
exec i3
