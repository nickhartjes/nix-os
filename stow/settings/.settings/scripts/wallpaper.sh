# Directory containing wallpapers
wallpaper_dir="$HOME/.wallpapers/"

# Get a random wallpaper file from the directory
random_wallpaper=$(find "$wallpaper_dir" -type f | shuf -n 1)

echo "Setting wallpaper to $random_wallpaper"

transition_type="random"
swww img $random_wallpaper \
  --transition-bezier .43,1.19,1,.4 \
  --transition-fps=60 \
  --transition-type=$transition_type \
  --transition-duration=0.7