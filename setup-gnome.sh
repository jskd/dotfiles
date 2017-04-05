#!/usr/bin/env bash

profileID=$(gsettings get org.gnome.Terminal.ProfilesList default)
profileID=${profileID:1:-1}

schemaName="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileID/"

foreground="#eaeaea"
background="#000000"
cursorColor="#aeafad"
color0="#000000"
color1="#912226"
color2="#778900"
color3="#ae7b00"
color4="#1d2594"
color5="#682a9b"
color6="#2b6651"
color7="#929593"
color8="#666666"
color9="#cc6666"
color10="#b5bd68"
color11="#f0c674"
color12="#81a2be"
color13="#b294bb"
color14="#8abeb7"
color15="#ecebec"

palette="['$color0'"
for i in {1..15}
do
  name="color$i"
  palette="$palette,'${!name}'"
done
palette="$palette]"


gsettings set $schemaName allow-bold            true
gsettings set $schemaName audible-bell          false
gsettings set $schemaName background-color      $background
gsettings set $schemaName cursor-shape          'ibeam'
gsettings set $schemaName default-size-columns  80
gsettings set $schemaName font                  'InconsolataForPowerline Nerd Font Medium 12'
gsettings set $schemaName foreground-color      $foreground
gsettings set $schemaName palette               $palette
gsettings set $schemaName rewrap-on-resize        true
gsettings set $schemaName scroll-on-output      false
gsettings set $schemaName scrollbar-policy      'always'
gsettings set $schemaName use-system-font       false
gsettings set $schemaName use-theme-colors      false
gsettings set $schemaName visible-name          'custom'

schemaName="org.gnome.Terminal.Legacy.Settings"

gsettings set $schemaName confirm-close         false
gsettings set $schemaName dark-theme            true
gsettings set $schemaName default-show-menubar  false
gsettings set $schemaName encodings             "['UTF-8']"

cp $HOME/.dotfiles/tomorrow-theme/GEdit/Tomorrow-Night-Bright.xml $HOME/.local/share/gedit/styles/Tomorrow-Night-Bright.xml

schemaName="org.gnome.gedit.preferences.editor"

gsettings set $schemaName editor-font           'InconsolataForPowerline Nerd Font Medium 12'
gsettings set $schemaName scheme                'tomorrownightbright'
