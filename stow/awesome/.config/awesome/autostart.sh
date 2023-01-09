#!/bin/sh

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run nm-applet
run caffeine &
run xfce4-power-manager
run volumeicon
run flameshot

HOSTNAME=$(hostnamectl hostname)

if [ "$HOSTNAME" = "thinkpad" ]; then
    run bluebery-tray
    run xrandr --output eDP-1 --mode 1920x1080 --pos 5120x360 --rotate normal --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-2 --mode 2560x1440 --pos 2560x0 --rotate normal
    run feh --bg-scale --no-xinerama ~/.wallpapers/*.
fi
