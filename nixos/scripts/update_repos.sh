#!/usr/bin/env

# Base folder where all project folders will be located
BASE_FOLDER="/home/nh/projects"

# Function to clone or fetch repositories
# Accepts two arguments: a name for the folder and an array of repository URLs
clone_or_fetch() {
    local folder_name=$1
    local -n repos=$2  # Use nameref for indirect reference to the array

    # Full path for the project folder within the base folder
    local full_path="$BASE_FOLDER/$folder_name"

    # Create a directory with the specified folder name and enter it
    mkdir -p "$full_path"
    cd "$full_path"

    # Loop through the list of repository URLs
    for REPO_URL in "${repos[@]}"; do
        # Extract the repository name from the URL
        REPO_NAME=$(echo "$REPO_URL" | awk -F'/' '{print $NF}' | sed 's/.git$//')

        # Check if the repository directory already exists
        if [ -d "$REPO_NAME" ]; then
            echo "Repository $REPO_NAME already exists in $folder_name, fetching updates..."
            # Change to the repository directory and fetch updates
            (cd "$REPO_NAME" && git fetch)
        else
            echo "Cloning repository $REPO_NAME into $folder_name..."
            # Clone the repository
            git clone "$REPO_URL"
        fi
    done

    # Go back to the original directory
    cd - > /dev/null

    echo "Operation completed for $folder_name."
}


TRADER_FOLDER="trader"
TRADER_REPO_LIST=(
    "git@github.com:EnergyExchangeEnablersBV/entrnce-deal-platform.git"
    "git@github.com:EnergyExchangeEnablersBV/trader-robot.git"
    "git@github.com:EnergyExchangeEnablersBV/entrnce-brp-messaging-module"
    "git@github.com:EnergyExchangeEnablersBV/ebmm-robot"
    
)
clone_or_fetch "$TRADER_FOLDER" TRADER_REPO_LIST

DEVOPS_FOLDER="devops"
DEVOPS_REPO_LIST=(
    "git@github.com:EnergyExchangeEnablersBV/entrnce-k8s-gitops.git"
    "git@github.com:EnergyExchangeEnablersBV/devops-gitops.git"
    "git@github.com:EnergyExchangeEnablersBV/ephemeral-environment-playground.git"
    "git@github.com:EnergyExchangeEnablersBV/aws-cdk.git"
    "git@github.com:EnergyExchangeEnablersBV/devops-aws-cdk.git"
    "git@github.com:EnergyExchangeEnablersBV/devops-helm-charts.git"
)
clone_or_fetch "$DEVOPS_FOLDER" DEVOPS_REPO_LIST

MATCHER_FOLDER="matcher"
MATCHER_REPO_LIST=(
    "git@github.com:EnergyExchangeEnablersBV/matcher-advisor.git"
)
clone_or_fetch "$MATCHER_FOLDER" MATCHER_REPO_LIST

NH_FOLDER="nh"
NH_REPO_LIST=(
    "git@github.com:nickhartjes/talos"
    "git@github.com:nickhartjes/gitops"
    "git@github.com:nickhartjes/velo-scraper"
    "git@github.com:nickhartjes/bikeparts-pricewatch"
    "git@github.com:nickhartjes/bikeparts-frontend-fennec"
)
clone_or_fetch "$NH_FOLDER" NH_REPO_LIST