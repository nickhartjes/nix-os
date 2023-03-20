#!/bin/sh

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run caffeine
run ulauncher
run variety
run xfce4-power-manager
run volumeicon
run flameshot
