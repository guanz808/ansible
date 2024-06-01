##!/bin/bash
#
## colors
#red=`tput setaf 1`
#green=`tput setaf 2`
#
## install ansible
#sudo apt-add-repository ppa:ansible/ansible -y
#sudo apt update -y
#sudo apt install ansible -y
#ansible --version
#
## Check if the ansible repository is present, if not clone the repo locally
#if [ ! -d ~/ansible ]; then
#  # Directory doesn't exist, clone the repository
#  echo "${green}Directory ~/ansible not found. Cloning the repository... $(tput sgr0)"
#  cd ~
#  git clone https://github.com/guanz808/ansible.git
#  cd ~/ansible
#else
#  # Directory exists, and update the repo
#  echo "${green}Directory ~/ansible already exists. $(tput sgr0)"
#  cd ~/ansible
#  #git reset --hard origin/main
#  git pull
#fi
#
## Check if the .vault_key file exists
#if [ ! -f ~/ansible/.vault_key ]; then
#  # Check if the temporary key file exists
#  if [ -f ~/ansible/.vault_key_tmp ]; then
#    echo "${green}Renaming temporary .vault_key_tmp to .vault_key $(tput sgr0)"
#    # Make a copy of the .vault_key_tmp and rename it to .vault_key
#    cp ~/ansible/.vault_key_tmp ~/ansible/.vault_key
#    # Prompt for Key
#    echo "${green}Please enter the vault key $(tput sgr0)"
#    read -s KEY
#    echo
#    echo "${green}Please enter the vault key again for confirmation: $(tput sgr0)"
#    read -s KEY_CONFIRM
#    echo
#      if [ "$KEY" == "$KEY_CONFIRM" ]; then
#          echo "$KEY" > ~/ansible/.vault_key
#      else
#          echo "${green}The vault key do not match. $(tput sgr0)"
#      fi
#    else
#      echo "${green}No vault key found. $(tput sgr0)"
#    fi
#else
#  echo "${green}Main vault key already exists. $(tput sgr0)"
#fi
#
## Check the .vault_key file if it contains the key, if not prompt for the key.
#if [[ $(stat -c %s ~/ansible/.vault_key) -gt 1 ]]; then
#  echo "${green}The ansible vault [~/ansible/.vault_key] key is present. $(tput sgr0)"
#else
#  echo "${green}The ansible vault [~/ansible/.vault_key] doesn't contain the key. $(tput sgr0)"
#  echo "${green}Please enter the vault key $(tput sgr0)"
#  read -s KEY
#  echo
#  echo "${green}Please enter the vault key again for confirmation: $(tput sgr0)"
#  read -s KEY_CONFIRM
#  echo
#    if [ "$KEY" == "$KEY_CONFIRM" ]; then
#        echo "$KEY" > ~/ansible/.vault_key
#    else
#        echo "${red}The vault key do not match. $(tput sgr0)"
#    fi
#  fi
#
#cd ~/ansible
#
#echo "${green}Running ansible playbook $(tput sgr0)"
#ansible-playbook main.yml --become

#!/bin/bash

# Colors (use predefined variables)
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

# Install Ansible
echo -e "${green}Installing Ansible...${reset}"
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
ansible --version

# Clone Ansible repository (if not already present)
if [ ! -d $HOME/ansible ]; then
  echo -e "${green}Directory $HOME/ansible not found. Cloning the repository...${reset}"
  git clone https://github.com/guanz808/ansible.git $HOME/ansible
else
  echo -e "${green}Directory $HOME/ansible already exists. Updating...${reset}"
  cd $HOME/ansible
  git pull
fi

# Handle Vault key
if [ ! -f $HOME/ansible/.vault_key ]; then
  if [ -f $HOME/ansible/.vault_key_tmp ]; then
    echo -e "${green}Renaming temporary .vault_key_tmp to .vault_key${reset}"
    mv $HOME/ansible/.vault_key_tmp $HOME/ansible/.vault_key

    # Prompt for key with confirmation (use loop)
    while true; do
      echo -e "${green}Please enter the vault key:${reset}"
      read -s KEY
      echo
      echo -e "${green}Please enter the vault key again for confirmation:${reset}"
      read -s KEY_CONFIRM
      echo

      if [ "$KEY" == "$KEY_CONFIRM" ]; then
        echo "$KEY" > $HOME/ansible/.vault_key
        break
      else
        echo -e "${red}The vault key do not match.${reset}"
      fi
    done
  else
    echo -e "${green}No vault key found.${reset}"
  fi
else
  echo -e "${green}Main vault key already exists.${reset}"
fi

# Check .vault_key content (use stat command for file size)
if [ $(stat -c %s $HOME/ansible/.vault_key) -gt 1 ]; then
  echo -e "${green}The ansible vault [$HOME/ansible/.vault_key] key is present.${reset}"
else
  # Prompt for key with confirmation (use loop)
  while true; do
    echo -e "${green}The ansible vault [$HOME/ansible/.vault_key] doesn't contain the key.${reset}"
    echo -e "${green}Please enter the vault key:${reset}"
    read -s KEY
    echo
    echo -e "${green}Please enter the vault key again for confirmation:${reset}"
    read -s KEY_CONFIRM
    echo

    if [ "$KEY" == "$KEY_CONFIRM" ]; then
      echo "$KEY" > $HOME/ansible/.vault_key
      break
    else
      echo -e "${red}The vault key do not match.${reset}"
    fi
  done
fi

# Run Ansible playbook
cd $HOME/ansible
echo -e "${green}Running ansible playbook...${reset}"
ansible-playbook main.yml --become
