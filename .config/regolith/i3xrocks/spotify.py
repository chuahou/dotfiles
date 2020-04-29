#!/usr/bin/python3

import dbus
import subprocess

# get spotify session and metadata
session_bus = dbus.SessionBus()
spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify",
    "/org/mpris/MediaPlayer2")
spotify_properties = dbus.Interface(spotify_bus,
    "org.freedesktop.DBus.Properties")
metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
title = metadata['xesam:title']
artist = metadata['xesam:artist'][0]

# get Xresource color, font and icon
value_color = subprocess.check_output(
    "xrescat i3xrocks.value.color \"#D8DEE9\"",
    shell = True).decode("utf-8")
value_font = subprocess.check_output(
    "xrescat i3xrocks.value.font \"Source Code Pro Medium 13\"",
    shell = True).decode("utf-8")
label_icon = subprocess.check_output(
    "xrescat i3xrocks.label.mediaplaying", shell = True).decode("utf-8")
label_color = subprocess.check_output(
    "xrescat i3xrocks.label.color \"#7B8394\"",
    shell = True).decode("utf-8")

# print output
print("<span color=\"" + label_color + "\">" + label_icon + "</span>" +
    "<span font_desc=\"" + value_font + "\" color=\"" + value_color +
    "\" size=\"small\"> " + artist + " | " + title + "</span>")

