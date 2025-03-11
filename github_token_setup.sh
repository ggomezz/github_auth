#!/bin/bash
set -eou pipefail

# Install and update git, if needed
##########################################
sudo -v
sudo apt update && sudo apt upgrade -y
sudo apt install -q -y --no-install-recommends git

# Retrieve user's username and email
##########################################
clear -x
echo 'What is your GitHub username?'
read GITHUB_USERNAME

echo 'What is your GitHub email?'
read GITHUB_EMAIL

echo 'What is your GitHub personal token?'
read -s GITHUB_TOKEN

echo 'For how many hours should your token be cached?'
read GITHUB_CACHE_HOURS
let GITHUB_CACHE_HOURS=${GITHUB_CACHE_HOURS}*3600 # needs to be in seconds
sleep 2

# Set the GitHub username, email, and auth token
##########################################
git config --global credential."https://github.com".username ${GITHUB_USERNAME}
git config --global credential."https://github.com".email ${GITHUB_EMAIL}
git config --global credential."https://github.com".helper "cache --timeout=${GITHUB_CACHE_HOURS}"

# new line before EOF marks end of approve command
git credential approve <<EOF
protocol=https
host=github.com
username=${GITHUB_USERNAME}
password=${GITHUB_TOKEN}

EOF

# Success
##########################################
clear -x
echo 'Succesfully cached GitHub email, username, and personal auth token.'
cat <<EOF
    protocol=https
    host=github.com
    email=${GITHUB_EMAIL}
    username=${GITHUB_USERNAME}
    password=[PERSONAL_AUTH_TOKEN]
EOF

unset GITHUB_USERNAME && unset GITHUB_EMAIL && unset GITHUB_TOKEN && unset GITHUB_CACHE_HOURS
