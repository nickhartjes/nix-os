#!/nix/store/dsd5gz46hdbdk2rfdimqddhq6m8m8fqs-bash-5.1-p16/bin/bash

# This is a helper to the arch-updates.py executor
# Add `<your-terminal-here> -e "au.sh; swaymsg reload"` as the On left click action

# Just in case - warn if battery level < threshold
l=$(acpi | awk -F ',' '{print $2}')
if [[ ! -z "$l" ]]; then
    level=${l:1:-1}
    threshold=30
    if [[ "$level" -lt "$threshold" ]]; then
	    echo -e "\n*** BATTERY LEVEL$l, CONNECT AC! ***\n"
    fi
fi

trizen -Syu &&
rm /tmp/arch-updates
echo Press enter to exit!; read;
