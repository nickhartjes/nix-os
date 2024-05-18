# Function to set BW_SESSION
function set_bw_session() {
  # Prompt the user for their Bitwarden master password
  read -s -p "Enter your Bitwarden master password: " BW_PASSWORD
  echo

  # Try to unlock Bitwarden and capture the output
  BW_UNLOCK_OUTPUT=$(bw unlock "$BW_PASSWORD" --raw 2>&1)

  # Check if the unlock command gave an error
  if [[ $? -ne 0 ]]; then
    echo "Unlock failed. Please login."

    # Prompt the user for their Bitwarden email
    read -p "Enter your Bitwarden email: " BW_EMAIL

    # Prompt the user for their Bitwarden password (again)
    read -s -p "Enter your Bitwarden password: " BW_LOGIN_PASSWORD
    echo

    # Attempt to login and capture the output
    BW_LOGIN_OUTPUT=$(bw login "$BW_EMAIL" "$BW_LOGIN_PASSWORD" --raw)

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
  # Save the session to .token file
  echo "$BW_SESSION" > ~/.token
  # Print the current BW_SESSION for verification
  echo "BW_SESSION is set to: $BW_SESSION"
  # Return the session
  echo "$BW_SESSION"
}

# Function to ensure Bitwarden session is active
function ensure_bw_session() {
  if [[ ! -f ~/.token ]]; then
    BW_SESSION=$(set_bw_session)
    if [[ $? -ne 0 ]]; then
      echo "Failed to obtain Bitwarden session."
      exit 1
    fi
  else
    BW_SESSION=$(cat ~/.token)
    export BW_SESSION

    # Verify if the session is still valid by listing an item
    bw list items --session "$BW_SESSION" &> /dev/null
    if [[ $? -ne 0 ]]; then
      echo "Session expired. Re-authenticating..."
      BW_SESSION=$(set_bw_session)
      if [[ $? -ne 0 ]]; then
        echo "Failed to obtain Bitwarden session."
        exit 1
      fi
    fi
  fi
}

# Function to download and import PGP keys from Bitwarden
download_and_import_pgp_keys() {
    ensure_bw_session

    # Get the item ID from Bitwarden
    item_id=$(bw list items --search gpgkey --session "$BW_SESSION" | jq -r '.[0].id')
    if [[ -z "$item_id" ]]; then
        echo "No pgpkeys item found in Bitwarden."
        return 1
    fi

    # Define the attachment names
    private_key="private.pgp"
    public_key="public.pgp"

    # Download and save the private key
    bw get attachment "$private_key" --itemid "$item_id" --session "$BW_SESSION" --raw > "$private_key"
    if [[ $? -eq 0 ]]; then
        chmod 600 "$private_key"
        echo "Private key retrieved and saved as: $private_key"
    else
        echo "Failed to retrieve private key from Bitwarden."
        return 1
    fi

    # Download and save the public key
    bw get attachment "$public_key" --itemid "$item_id" --session "$BW_SESSION" --raw > "$public_key"
    if [[ $? -eq 0 ]]; then
        chmod 600 "$public_key"
        echo "Public key retrieved and saved as: $public_key"
    else
        echo "Failed to retrieve public key from Bitwarden."
        return 1
    fi

    # Import the public key into GPG
    gpg --import "$public_key"
    if [[ $? -eq 0 ]]; then
        echo "Public key imported successfully."
    else
        echo "Failed to import public key."
        return 1
    fi

    # Import the private key into GPG
    gpg --import "$private_key"
    if [[ $? -eq 0 ]]; then
        echo "Private key imported successfully."
    else
        echo "Failed to import private key."
        return 1
    fi

    # List the secret keys in GPG
    gpg --list-secret-keys
}

# Function to generate a LUKS keyfile
generate_keyfile() {
    # Prompt for the hostname
    read -p "Enter the hostname to be used: " hostname

    # Define the keyfile name using the provided hostname with .luks.key extension
    keyfile_name="${hostname}.luks.key"

    # Generate the keyfile
    dd if=/dev/urandom of="${keyfile_name}" bs=1024 count=4
    chmod 600 "${keyfile_name}"

    echo "Keyfile generated: ${keyfile_name}"
}

# Function to save a keyfile to Bitwarden
save_key_to_bitwarden() {
    ensure_bw_session

    # Ask for the keyfile name
    read -p "Enter the name of the keyfile: " keyfile_name

    # Check if the file exists
    if [[ ! -f "${keyfile_name}" ]]; then
        echo "Keyfile not found: ${keyfile_name}"
        exit 1
    fi

    # Get the item ID from Bitwarden
    item_id=$(bw list items --search luks --session "$BW_SESSION" | jq -r '.[0].id')
    if [[ -z "$item_id" ]]; then
        echo "No LUKS item found in Bitwarden."
        exit 1
    fi

    # Save the keyfile to Bitwarden
    bw create attachment --file "${keyfile_name}" --itemid "${item_id}" --session "$BW_SESSION"
    if [[ $? -eq 0 ]]; then
        echo "Keyfile saved to Bitwarden."
    else
        echo "Failed to save keyfile to Bitwarden."
    fi
}

# Function to retrieve a keyfile from Bitwarden
retrieve_key_from_bitwarden() {
    ensure_bw_session

    # Ask for the hostname
    read -p "Enter the hostname to be used: " hostname

    # Define the keyfile name using the provided hostname with .luks.key extension
    keyfile_name="${hostname}.luks.key"

    # Get the item ID from Bitwarden
    item_id=$(bw list items --search luks --session "$BW_SESSION" | jq -r '.[0].id')
    if [[ -z "$item_id" ]]; then
        echo "No LUKS item found in Bitwarden."
        exit 1
    fi

    # Retrieve the keyfile from Bitwarden
    bw get attachment "${keyfile_name}" --itemid "${item_id}" --session "$BW_SESSION" --raw > "${keyfile_name}"
    if [[ $? -eq 0 ]]; then
        chmod 600 "${keyfile_name}"
        echo "Keyfile retrieved and saved as: ${keyfile_name}"
    else
        echo "Failed to retrieve keyfile from Bitwarden."
    fi
}

# Function to add packages to NixOS configuration
add_packages_to_nix_config() {
    local packages=("vim" "wget" "curl" "gnupg" "git" "git-crypt" "bitwarden-cli" "jq")
    local config_file="/etc/nixos/configuration.nix"

    # Create a temporary file to store the modified configuration
    local tmp_file=$(mktemp)

    # Read through the configuration file
    sudo awk -v packages="${packages[*]}" '
    BEGIN {
        split(packages, package_array, " ")
    }
    {
        print
        if ($0 ~ /environment.systemPackages = with pkgs; \[/) {
            # Read the lines within the package list
            in_list = 1
            while (getline > 0) {
                if ($0 ~ /\]/) {
                    break
                }
                existing_packages[$0] = 1
            }
            for (i in package_array) {
                package = package_array[i]
                if (!(package in existing_packages)) {
                    print "    " package
                }
            }
            print "]"
            in_list = 0
        }
    }
    ' "$config_file" > "$tmp_file"

    # Move the temporary file to the original configuration file
    sudo mv "$tmp_file" "$config_file"
}

# Main menu
while true; do
    echo "What would you like to do?"
    echo "1) Generate a new LUKS keyfile"
    echo "2) Save an existing keyfile to Bitwarden"
    echo "3) Retrieve a keyfile from Bitwarden"
    echo "4) Download and import PGP keys from Bitwarden"
    echo "5) Add packages to NixOS configuration"
    echo "6) Exit"
    read -p "Enter your choice (1, 2, 3, 4, 5, or 6): " choice

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
            download_and_import_pgp_keys
            ;;
        5)
            add_packages_to_nix_config
            ;;
        6)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, 3, 4, 5, or 6."
            ;;
    esac
done
