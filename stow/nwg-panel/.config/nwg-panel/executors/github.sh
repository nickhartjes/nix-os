#!/nix/store/dsd5gz46hdbdk2rfdimqddhq6m8m8fqs-bash-5.1-p16/bin/bash

# Based on the 'Github notifications' example from Waybar's Wiki
# Depends on jq Command-line JSON processor
# Obtain a notifications token at https://github.com/settings/tokens
# save it to a file as below.

token=`cat ${HOME}/.config/github/notifications.token`
count=`curl -u nwg-piotr:${token} https://api.github.com/notifications -s | jq '. | length'`

if [[ "$count" != "0" ]]; then
    echo /home/piotr/.config/nwg-panel/icons_light/github.svg
    echo $count
fi
