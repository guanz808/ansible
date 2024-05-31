#!/bin/bash

# colors
red=`tput setaf 1`
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
fi

# Check if the .vault_key file exists
if [ ! -f ~/ansible/.vault_key ]; then
  # Check if the temporary key file exists
  if [ -f ~/ansible/.vault_key_tmp ]; then
    echo "${green}Renaming temporary .vault_key_tmp to .vault_key $(tput sgr0)"
    # Make a copy of the .vault_key_tmp and rename it to .vault_key
    cp ~/ansible/.vault_key_tmp ~/ansible/.vault_key
    # Prompt for Key
    echo "${green}Please enter the vault key $(tput sgr0)"
    read -s KEY
    echo
    echo "${green}Please enter the vault key again for confirmation: $(tput sgr0)"
    read -s KEY_CONFIRM
    echo
      if [ "$KEY" == "$KEY_CONFIRM" ]; then
          echo "$KEY" > ~/ansible/.vault_key
      else
          echo "${green}The vault key do not match. $(tput sgr0)"
      fi
    else
      echo "${green}No vault key found. $(tput sgr0)"
    fi
else
  echo "${green}Main vault key already exists. $(tput sgr0)"
fi

# Check the .vault_key file if it contains the key, if not prompt for the key.
if [[ $(stat -c %s ~/ansible/.vault_key) -gt 1 ]]; then
  echo "${green}The ansible vault [~/ansible/.vault_key] key is present. $(tput sgr0)"
else
  echo "${green}The ansible vault [~/ansible/.vault_key] doesn't contain the key. $(tput sgr0)"
  echo "${green}Please enter the vault key $(tput sgr0)"
  read -s KEY
  echo
  echo "${green}Please enter the vault key again for confirmation: $(tput sgr0)"
  read -s KEY_CONFIRM
  echo
    if [ "$KEY" == "$KEY_CONFIRM" ]; then
        echo "$KEY" > ~/ansible/.vault_key
    else
        echo "${red}The vault key do not match. $(tput sgr0)"
    fi
  fi

#echo "${green}Getting key vault value $(tput sgr0)"
#cat ~/ansible/.vault_key

echo "${green}Running ansible playbook $(tput sgr0)"
ansible-playbook main.yml --become