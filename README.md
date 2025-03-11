# github_auth
Collection of bash scripts that are useful for setting up Git for use with private GitHub repos. 

## Authentication with Open SSH Client
Running the SSH setup script will install `openssh-client` and `git` , if needed. The script assumes that all SSH keys will be stored at `~/.ssh`. Setting up authentication through SSH is more secure because the private key can be configured through the prompts to have password protection.

### 1. Install Git
```sh
sudo apt update && sudo apt upgrade -y 
```
```sh
sudo apt install git
```

### 2. Clone this repo
```sh
git clone https://github.com/ggomezz/github_auth.git
```

### 3. Make the SSH setup file an executable
```sh
sudo chmod u+x github_auth/github_ssh_setup.sh
```

### 4. Execute github_ssh_setup.sh and follow the prompts
```sh
source github_auth/github_ssh_setup.sh
```

### 5. Add the public SSH key to your GitHub account
Once the script has finished, you will see:
> SSH setup is complete. Add the contents of the public key to your GitHub account:
> [############# public key ############# ]

The public key can be added to your GitHub account at https://github.com/settings/keys.

## Authentication with Personal Access Token
Running the token setup script will install `git` , if needed. Personal access tokens will be stored in Git's cache until the designated expiration time. The script can be re-run to setup authentication with a new personal auth token, after expiration.

Although your personal access token won't be stored as plain text, setting up authentication through the personal access token is less secure. While the cache is unexpired, tokens can be easily retrieved from the cache without any additional authentication.

You can read more about using Git's cache as a credential manager at https://git-scm.com/docs/git-credential-cache.

### 1. Install Git
```sh
sudo apt update && sudo apt upgrade -y 
```
```sh
sudo apt install git
```

### 2. Clone this repo
```sh
git clone https://github.com/ggomezz/github_auth.git
```

### 3. Make the token setup file an executable
```sh
sudo chmod u+x github_auth/github_token_setup.sh
```

### 4. Generate a personal access token
Personal access tokens are found under Developer Settings. When generating a personal access token, the token must have the `write:packages` permission in order to allow a user to clone private repositories. Personal access tokens are only viewable immediately after creation. Make sure to copy down the token because it will be requested when running the setup script.

You can manage and generate personal access tokens at https://github.com/settings/tokens.

### 5. Execute github_token_setup.sh and follow the prompts
```sh
source github_auth/github_token_setup.sh
```
