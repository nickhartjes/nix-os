#!/bin/sh
cd projets/lakeside
while true; do
    PID=`pidof swaybg`
    swaybg -i ./img/$(date -u -d @$((($(date -u +%s) / 600) * 600)) "+%Hh%M").png -m fill &
    sleep 1
    kill $PID
    sleep 599
done
