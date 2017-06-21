#!/usr/bin/env bash

profileID=$(gsettings get org.gnome.Terminal.ProfilesList default)
profileID=${profileID:1:-1}

schemaName="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profileID/"

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

schemaName="org.gnome.gedit.preferences.editor"

gsettings set $schemaName editor-font           'InconsolataForPowerline Nerd Font Medium 12'
