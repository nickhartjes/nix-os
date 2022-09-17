#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#

echo "Upgrading NixOs"

cd ~/.setup
sudo nix-channel --update
nix flake update --commit-lock-file
sudo nixos-rebuild switch --upgrade  --flake .#"$HOST"

echo 'Reboot? (y/n)' && read x && [[ "$x" == "y" ]] && sudo reboot -h now;
