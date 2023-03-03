#!/bin/sh
waltile() {
    wallpaper=$(find ~/.wallpapers/. -type f | shuf -n1)
#    wal -n -i "$wallpaper"
    swaybg -i $wallpaper -m fill &
}
waltile
OLD_PID=$!
while true; do
    sleep 600
    waltile
    NEXT_PID=$!
#    sleep 5
    kill $OLD_PID
    OLD_PID=$NEXT_PID
done

