wallpaper_engine=$(cat $HOME/.settings/wallpaper-engine.conf)
if [ "$wallpaper_engine" == "swww" ] ;then
    # swww
    echo ":: Using swww"
    swww-daemon --format xrgb
    sleep 0.5
    ~/.settings/scripts/wallpaper.sh init
elif [ "$wallpaper_engine" == "hyprpaper" ] ;then    
    # hyprpaper
    echo ":: Using hyprpaper"
    sleep 0.5
    ~/.settings/scripts/wallpaper.sh init
else
    echo ":: Wallpaper Engine disabled"
    ~/.settings/scripts/wallpaper.sh init
fi
