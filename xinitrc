#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrandr --output HDMI1 --left-of HDMI2
xrandr --output VGA1 --left-of HDMI1

xrdb -merge -I$HOME ~/.Xresources

numlockx &

exec awesome
