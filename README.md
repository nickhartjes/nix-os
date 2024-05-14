# NH System Flake Configuration and Config files
![NixOs](./doc/NixOS.svg)

## How to install from a clean install

### Step 01: Disko time (optional)
Disko is a way to to declartive disk partitioning in NixOs.
There is a good [quickstart guide](https://github.com/nix-community/disko/blob/master/docs/quickstart.md) about it. The disko configurtion i am using is in the `disko.nix` file.

```shell
# Set the hostname
hostname="nixos"

# Define the keyfile name using the hostname with .luks.key extension
keyfile_name="${hostname}.luks.key"

# Generate the keyfile
dd if=/dev/urandom of=${keyfile_name} bs=1024 count=4

# Set appropriate permissions
chmod 600 ${keyfile_name}
```


```shell
# Read the keyfile content
keyfile_content=$(cat ${keyfile_name})

# Log in to Bitwarden CLI
bw login

# Create a secure note in Bitwarden with the keyfile content
bw create item '{"type": 2, "name": "'"${hostname} LUKS Keyfile"'", "notes": "'"${keyfile_content}"'"}'
```


### Step 01: Clone the repo in `~/.setup` folder
```shell
nix-env -iA nixos.curl
curl -Lks https://raw.githubusercontent.com/nickhartjes/nix-os/main/scripts/install.sh | /bin/bash
```

### Step 02:



## More info
```shell
git-crypt unlock
```
- [Git-crypt](https://www.agwa.name/projects/git-crypt/)
