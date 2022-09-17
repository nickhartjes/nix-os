#!/bin/bash
#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#

echo "Installing git, git-crypt and gnupg"
nix-env -iA nixos.curl nixos.git nixos.git-crypt nixos.gnupg

if [[ -d "$HOME/.setup" ]]
then
    echo "Pulling the latest files."
    cd ~/.setup
    git pull --recurse-submodules
else
    echo "Cloning NixOs Flake in ~/.setup folder"
    git clone --recurse-submodules git@github.com:nickhartjes/nix-os.git ~/.setup
fi
