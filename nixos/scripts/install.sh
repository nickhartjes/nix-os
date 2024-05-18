#!/bin/bash
#  __   __   __    __
# |  \ |  | |  |  |  |
# |   \|  | |  |__|  |  Nick Hartjes
# |    `  | |   __   |  https://nickhartjes.nl
# |  |\   | |  |  |  |  https://github.com/nickhartjes/
# |__| \__| |__|  |__|
#

# Install all necessary software
echo "Installing curl, git, git-crypt, gnupg, and gh"
nix-env -iA nixos.curl nixos.git nixos.git-crypt nixos.gnupg nixos.gh

# Check if SSH key exists
if [[ -f "$HOME/.ssh/id_rsa" ]]
then
    echo "SSH key already exists."
else
    echo "SSH key not found. Generating a new SSH key."

    # Prompt for the email and hostname
    read -p "Enter your email: " user_email
    read -p "Enter the hostname to be used: " hostname

    # Generate a new SSH key
    ssh-keygen -t rsa -b 4096 -C "$user_email" -f "$HOME/.ssh/id_rsa" -N ""

    echo "SSH key generated."

    echo "Adding SSH key to your GitHub account."

    # Authenticate with GitHub
    gh auth login

    # Add SSH key to GitHub
    gh ssh-key add "$HOME/.ssh/id_rsa.pub" -t "My SSH Key - $hostname"

    echo "SSH key added to your GitHub account."
fi

if [[ -d "$HOME/.setup" ]]
then
    echo "Pulling the latest files."
    cd ~/.setup
    git pull --recurse-submodules
else
    echo "Cloning NixOs Flake in ~/.setup folder"
    git clone --recurse-submodules git@github.com:nickhartjes/nix-os.git ~/.setup
fi
