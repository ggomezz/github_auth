#!/bin/bash
set -eou pipefail

# Retrieve user's username and email
##########################################
echo 'What is your GitHub username?'
read GITHUB_USERNAME

echo 'What is your GitHub email?'
read GITHUB_EMAIL

# Install git
##########################################
clear -x
echo "Installing GitHub and Open SSH Client..."

sudo -v
sudo apt update && sudo apt upgrade -y
sudo apt install -q -y --no-install-recommends git openssh-client

# Set the GitHub username and email
git config --global --replace-all user."https://github.com".username ${GITHUB_USERNAME}
git config --global --replace-all user."https://github.com".email ${GITHUB_EMAIL}

# Make SSH key
##########################################
clear -x
mkdir -p ~/.ssh
echo 'Generating a new SSH key named id_ed25519. Please respond to the following prompts.'
echo 'Enter passphrase for SSH key (empty for no passphrase)'
read -r SSH_PSWD

sudo rm -f ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
ssh-keygen -t ed25519 -C "${GITHUB_EMAIL}" -N "${SSH_PSWD}" -f ~/.ssh/id_ed25519
unset SSH_PSWD

# Set correct permissions
sudo chmod 600 ~/.ssh/id_ed25519
sudo chmod 644 ~/.ssh/id_ed25519.pub
sudo chmod 700 ~/.ssh

# Add GitHub to known hosts
touch ~/.ssh/known_hosts
echo >> ~/.ssh/known_hosts
ssh-keyscan github.com >> ~/.ssh/known_hosts

# Give user the public key
clear -x
echo 'SSH setup is complete. Add the contents of the public key to your GitHub account:'
cat ~/.ssh/id_ed25519.pub
