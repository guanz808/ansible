#!/bin/bash

# colors
green=`tput setaf 2`

# install ansible
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
ansible --version

if [ ! -d ~/ansible ]; then
  # Directory doesn't exist, clone the repository
  echo "${green}Directory ~/ansible not found. Cloning the repository... $(tput sgr0)"
  cd ~
  git clone https://github.com/guanz808/ansible.git
  cd ~/ansible
else
  # Directory exists, handle existing content (optional)
  echo "${green}Directory ~/ansible already exists. $(tput sgr0)"
  cd ~/ansible
  #git reset --hard origin/main
  git pull
  #git fetch --all
fi

# Check if the main vault key file exists
if [ ! -f ~/ansible/.vault_key ]; then
  # Check if the temporary key file exists
  if [ -f ~/ansible/.vault_key_tmp ]; then
    echo "${green}Renaming temporary vault key to main key... $(tput sgr0)"
    # Move the temporary file to the main key location
    cp ~/ansible/.vault_key_tmp ~/ansible/.vault_key
    # Prompt for Key
    echo "${green}Enter vault key $(tput sgr0)"
    read -p "Enter the vault key: " key
  else
    echo "${green}No vault key found. $(tput sgr0)"
  fi
else
  echo "${green}Main vault key already exists. $(tput sgr0)"
fi

if [[ $(stat -c %s ~/ansible/.vault_key) -gt 0 ]]; then
  echo "${green}~/ansible/.vault_key has content. $(tput sgr0)"
else
  echo "${green}~/ansible/.vault_key is empty or doesn't exist. $(tput sgr0)"
  # Add the key to the vault_key file
  echo "$key" > ~/ansible/.vault_key
fi

echo "${green}getting key vault value $(tput sgr0)"
cat ~/ansible/.vault_key

echo "${green}Running ansible playbook $(tput sgr0)"
#ansible-playbook main.yml --become