#!/usr/bin/env bash

## Script To Manage Brightness, Sound, and Media Controls

iDIR="$HOME/.config/hypr/mako/icons"

# Get brightness
get_brightness() {
  LIGHT=$(printf "%.0f\n" $(brightnessctl g))
  MAX=$(brightnessctl m)
  PERCENT=$(echo "($LIGHT / $MAX) * 100" | bc -l)
  echo "${PERCENT%%%}%"
}

# Get icons
get_icon() {
  current="${1%%%}"
  case $current in
    brightness)
      case $2 in
        [0-2][0-9]|[0-9])
          icon="$iDIR/brightness-20.png"
          ;;
        3[0-9]|2[0-9])
          icon="$iDIR/brightness-40.png"
          ;;
        4[0-9]|5[0-9])
          icon="$iDIR/brightness-60.png"
          ;;
        6[0-9]|7[0-9])
          icon="$iDIR/brightness-80.png"
          ;;
        *)
          icon="$iDIR/brightness-100.png"
          ;;
      esac
      ;;
    sound)
      case $2 in
        mute)
          icon="$iDIR/sound-mute.png"
          ;;
        *)
          icon="$iDIR/sound-on.png"
          ;;
      esac
      ;;
    media)
      case $2 in
        play)
          icon="$iDIR/media-play.png"
          ;;
        pause)
          icon="$iDIR/media-pause.png"
          ;;
        next)
          icon="$iDIR/media-next.png"
          ;;
        previous)
          icon="$iDIR/media-previous.png"
          ;;
      esac
      ;;
  esac
}

# Notify
notify_user() {
  notify-send -t 3000 -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "$1 : $2"
}

# Brightness controls
brightness_controls() {
  case $1 in
    "--inc")
      brightnessctl s +5%
      ;;
    "--dec")
      brightnessctl s 5%-
      ;;
    *)
      echo "Invalid brightness control option"
      ;;
  esac
  current_brightness=$(get_brightness)
  get_icon "brightness" "$current_brightness"
  notify_user "Brightness" "$current_brightness"
}

# Media controls
media_controls() {
  case $1 in
    "--play-pause")
      status=$(playerctl status)
      if [[ "$status" == "Playing" ]]; then
        playerctl pause
        get_icon "media" "pause"
      else
        playerctl play
        get_icon "media" "play"
      fi
      notify_user "Media" "$status"
      ;;
    "--next")
      playerctl next
      get_icon "media" "next"
      notify_user "Media" "Next Track"
      ;;
    "--previous")
      playerctl previous
      get_icon "media" "previous"
      notify_user "Media" "Previous Track"
      ;;
    *)
      echo "Invalid media control option"
      ;;
  esac
}

# Sound controls
sound_controls() {
  case $1 in
    "--volume-up")
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      get_icon "sound" "unmute"
      notify_user "Sound" "Volume Up"
      ;;
    "--volume-down")
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      get_icon "sound" "unmute"
      notify_user "Sound" "Volume Down"
      ;;
    "--mute-toggle")
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep '[MUTED]' | wc -l)
      if [[ "$is_muted" == "1" ]]; then
        get_icon "sound" "mute"
        notify_user "Sound" "Muted"
      else
        get_icon "sound" "unmute"
        notify_user "Sound" "Unmuted"
      fi
      ;;
    *)
      echo "Invalid sound control option"
      ;;
  esac
}


# Execute accordingly
case "$1" in
  "--get")
    get_brightness
    ;;
  "--inc"|"--dec")
    brightness_controls "$1"
    ;;
  "--play-pause"|"--next"|"--previous")
    media_controls "$1"
    ;;
  "--volume-up"|"--volume-down"|"--mute-toggle")
    sound_controls "$1"
    ;;
  *)
    echo "Invalid option"
    ;;
esac
