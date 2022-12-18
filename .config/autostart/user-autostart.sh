#!/bin/sh

# Fix Minecraft
wmname LG3D

# Set wallpaper
nitrogen --restore &

# Dunst (Notifications)
dunst_status=$(pgrep dunst)
if [ -z "$dunst_status" ]
then
    dunst &
fi

# Signal (Messaging)
signal_status=$(pgrep signal-desktop)
if [ -z "$signal_status" ]
then
    signal-desktop --start-in-tray --no-sandbox &
fi

# Discord (Messaging)
discord_status=$(pgrep Discord)
if [ -z "$discord_status" ]
then
    discord --start-minimized &
fi

# Slack (Messaging)
slack_status=$(pgrep slack)
if [ -z "$slack_status" ]
then
    slack -u &
fi

# Picom (Compositor)
picom_status=$(pgrep picom)
if [ -z "$picom_status" ]
then
    picom -b --unredir-if-possible --vsync --use-damage --glx-no-stencil &
fi

# Network Applet
nm_applet_status=$(pgrep nm-applet)
if [ -z "$nm_applet_status" ]
then
    nm-applet &
fi

# Bluetooth Applet
blueman_applet_status=$(pgrep blueman-applet)
if [ -z "$blueman_applet_status" ]
then
    blueman-applet &
fi

# PulseAudio Systray
pasystray_status=$(pgrep pasystray)
if [ -z "$pasystray_status" ]
then
    pasystray -g &
fi

# Battery Applet
cbatticon_status=$(pgrep cbatticon)
if [ -z "$cbatticon_status" ]
then
    cbatticon -i symbolic &
fi

# Gnome Polkit
polkit_gnome_status=$(pgrep polkit-gnome)
if [ -z "$polkit_gnome_status" ]
then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# Gnome Keyring
gnome_keyring_status=$(pgrep gnome-keyring)
if [ -z "$gnome_keyring_status" ]
then
    gnome-keyring-daemon --start --components=secrets &
fi

# Trayer (System Tray)
pkill trayer
trayer_status=$(pgrep trayer)
if [ -z "$trayer_status" ]
then
    trayer --edge top --height 30 --align right --widthtype pixel --iconspacing 5 --width 400 --padding 5 --transparent true --tint 0xff000000 --alpha 0 --margin 340
fi

# Emacs
emacs_status=$(pgrep emacs)
if [ -z "$emacs_status" ]
then
    emacs --daemon
fi

# Caffeine
caffeine &

