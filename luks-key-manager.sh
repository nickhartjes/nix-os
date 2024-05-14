#!/bin/bash

# Function to set BW_SESSION
function set_bw_session() {
  # Prompt the user for their Bitwarden master password
  read -s -p "Enter your Bitwarden master password: " BW_PASSWORD
  echo

  # Try to unlock Bitwarden and capture the output
  BW_UNLOCK_OUTPUT=$(bw unlock $BW_PASSWORD --raw 2>&1)

  # Check if the unlock command gave an error
  if [[ $? -ne 0 ]]; then
    echo "Unlock failed. Please login."

    # Prompt the user for their Bitwarden email
    read -p "Enter your Bitwarden email: " BW_EMAIL

    # Prompt the user for their Bitwarden password (again)
    read -s -p "Enter your Bitwarden password: " BW_LOGIN_PASSWORD
    echo

    # Attempt to login and capture the output
    BW_LOGIN_OUTPUT=$(bw login $BW_EMAIL $BW_LOGIN_PASSWORD --raw)

    # Check if the login command was successful
    if [[ $? -eq 0 ]]; then
      echo "Login successful."
      BW_SESSION=$BW_LOGIN_OUTPUT
    else
      echo "Login failed. Please check your credentials and try again."
      return 1
    fi
  else
    echo "Unlock successful."
    BW_SESSION=$BW_UNLOCK_OUTPUT
  fi

  # Export BW_SESSION to be available in the current shell session
  export BW_SESSION
  # Print the current BW_SESSION for verification
  echo "BW_SESSION is set to: $BW_SESSION"
  # Return the session
  echo $BW_SESSION
}

# Function to generate a LUKS keyfile
generate_keyfile() {
    # Prompt for the hostname
    read -p "Enter the hostname to be used: " hostname

    # Define the keyfile name using the provided hostname with .luks.key extension
    keyfile_name="${hostname}.luks.key"

    # Generate the keyfile
    dd if=/dev/urandom of=${keyfile_name} bs=1024 count=4
    chmod 600 ${keyfile_name}

    echo "Keyfile generated: ${keyfile_name}"
}

# Function to save a keyfile to Bitwarden
save_key_to_bitwarden() {
    # Ensure Bitwarden session is set
    if [ -z "$BW_SESSION" ]; then
        BW_SESSION=$(set_bw_session)
        if [ $? -ne 0 ]; then
            echo "Failed to obtain Bitwarden session."
            exit 1
        fi
    fi

    # Ask for the keyfile path
    read -p "Enter the name of the keyfile: " keyfile_name

    # Check if the file exists
    if [[ ! -f "${keyfile_name}" ]]; then
        echo "Keyfile not found: ${keyfile_name}"
        exit 1
    fi

    item_id=$(bw list items --search luks --session $BW_SESSION | jq -r '.[0].id')
    bw create attachment --file "${keyfile_name}" --itemid ${item_id} --session $BW_SESSION

    if [ $? -eq 0 ]; then
        echo "Keyfile saved to Bitwarden."
    else
        echo "Failed to save keyfile to Bitwarden."
    fi
}

# Function to retrieve a keyfile from Bitwarden
retrieve_key_from_bitwarden() {
    # Ensure Bitwarden session is set
    if [ -z "$BW_SESSION" ]; then
        BW_SESSION=$(set_bw_session)
        if [ $? -ne 0 ]; then
            echo "Failed to obtain Bitwarden session."
            exit 1
        fi
    fi

    # Ask for the hostname
read -p "Enter the hostname to be used: " hostname

    # Define the keyfile name using the provided hostname with .luks.key extension
    keyfile_name="${hostname}.luks.key"

    item_id=$(bw list items --search luks --session $BW_SESSION | jq -r '.[0].id')
    bw get attachment "${keyfile_name}" --itemid ${item_id} --session $BW_SESSION

    if [ -z "$item" ]; then
        echo "No keyfile found for hostname: ${hostname}"
        exit 1
    fi

    echo "Keyfile retrieved and saved as: ${keyfile_name}"
}

# Main menu
while true; do
    echo "What would you like to do?"
    echo "1) Generate a new LUKS keyfile"
    echo "2) Save an existing keyfile to Bitwarden"
    echo "3) Retrieve a keyfile from Bitwarden"
    echo "4) Exit"
    read -p "Enter your choice (1, 2, 3, or 4): " choice

    case $choice in
        1)
            generate_keyfile
            
            ;;
        2)
            save_key_to_bitwarden
         
            ;;
        3)
            retrieve_key_from_bitwarden

            ;;
        4)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, 3, or 4."
            ;;
    esac
done
