# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
blur_file="$HOME/.settings/blur.sh"

blur="50x30"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$HOME/.wallpapers/default.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/.wallpapers/default.jpg\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in

    # Load wallpaper from .cache of last session 
    "init")
        sleep 1
        if [ -f $cache_file ]; then
            wal -q -i $current_wallpaper
        else
            wal -q -i ~/.wallpapers/
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        sleep 0.2
        #selected=$( find "$HOME/.wallpapers" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        selected=$(find ~/.wallpapers/. -type f | shuf -n1 )
        echo -en "$(basename "$selected")\x00icon\x1f$selected\n" | rofi -dmenu -i -p "Choose Wallpaper: " -config "$HOME/.config/rofi/config-wallpaper.rasi"
        # do
        #     echo -en "$rfile\x00icon\x1f$HOME/.wallpapers/${rfile}\n"
        # done | rofi -dmenu -i -replace -config ~/.config/rofi/config-wallpaper.rasi)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i ~/wallpaper/$selected
    ;;

    # Randomly select wallpaper 
    *)
        wal -q -i ~/.wallpapers/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$HOME/wallpaper/||g")

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
sh ~/.config/waybar/launch.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
# transition_type="wipe"
# transition_type="outer"
transition_type="random"

    swww img $wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 

wallpaper_engine=$(cat $HOME/.settings/wallpaper-engine.conf)
if [ "$wallpaper_engine" == "swww" ] ;then
    # swww
    echo ":: Using swww"
    swww img $wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=1.7 \
        --transition-pos "$( hyprctl cursorpos )"
elif [ "$wallpaper_engine" == "hyprpaper" ] ;then
    # hyprpaper
    echo ":: Using hyprpaper"
    killall hyprpaper
    wal_tpl=$(cat $HOME/dotfiles/.settings/hyprpaper.tpl)
    output=${wal_tpl//WALLPAPER/$wallpaper}
    echo "$output" > $HOME/dotfiles/hypr/hyprpaper.conf
    hyprpaper &
else
    echo ":: Wallpaper Engine disabled"
fi

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    notify-send "Changing wallpaper ..." "with image $newwall" -h int:value:33 -h string:x-dunst-stack-tag:wallpaper
    sleep 2
fi

# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    notify-send "Creating blurred version ..." "with image $newwall" -h int:value:66 -h string:x-dunst-stack-tag:wallpaper
fi

magick $wallpaper -resize 75% $blurred
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    magick $blurred -blur $blur $blurred
    echo ":: Blurred"
fi

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" > "$rasi_file"

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    notify-send "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"
