#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#

echo "Cleaning up NixOs"

sudo nix-collect-garbage -d
nix-collect-garbage -d
cd ~/.setup

sudo nixos-rebuild switch  --flake .#"$HOST"

echo 'Reboot? (y/n)' && read x && [[ "$x" == "y" ]] && sudo reboot -h now;
