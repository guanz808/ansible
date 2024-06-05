#!/bin/bash

# Colors (use predefined variables)
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

# Paths
VAULT_SECRET="$HOME/ansible/.vault_key"
ANSIBLE_DIR="$HOME/ansible/main.yml"

# Install Ansible
echo -e "${green}Installing Ansible...${reset}"
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
ansible --version

# Clone Ansible repository (if not already present) #### 6/5/24 ####
if [ ! -d ANSIBLE_DIR ]; then
  echo -e "${green}Directory $ANSIBLE_DIR not found. Cloning the repository...${reset}"
  git clone -b upgrade https://github.com/guanz808/ansible.git $ANSIBLE_DIR
else
  echo -e "${green}Directory $ANSIBLE_DIR already exists. Updating...${reset}"
  cd $ANSIBLE_DIR
  git pull origin upgrade
fi

# Handle Vault key
if [ ! -f $VAULT_SECRET ]; then
  if [ -f $ANSIBLE_DIR/.vault_key_tmp ]; then
    echo -e "${green}Renaming temporary .vault_key_tmp to .vault_key${reset}"
    cp $ANSIBLE_DIR/.vault_key_tmp $VAULT_SECRET
  else
    echo -e "${green}No vault key found.${reset}"
  fi

  # Prompt for key once and check confirmation internally
  echo -e "${green}Please enter the vault key:${reset}"
  read -s KEY
  echo

  if [[ ! $KEY ]]; then  # Check if key is empty
    echo -e "${red}Vault key cannot be empty.${reset}"
  else
    # Validate key format (optional, adjust as needed)
    # if ! your_key_validation_function "$KEY"; then
    #   echo -e "${red}Invalid vault key format.${reset}"
    # else
      echo "$KEY" > $VAULT_SECRET
    # fi
  fi
else
  echo -e "${green}Main vault key already exists.${reset}"
fi

# Check .vault_key content (use stat command for file size)
if [ $(stat -c %s $VAULT_SECRET) -gt 1 ]; then
  echo -e "${green}The ansible vault [$VAULT_SECRET] key is present.${reset}"
else
  # Prompt for key with confirmation (use loop)
  while true; do
    echo -e "${green}The ansible vault [$VAULT_SECRET] doesn't contain the key.${reset}"
    echo -e "${green}Please enter the vault key:${reset}"
    read -s KEY
    echo
    echo -e "${green}Please enter the vault key again for confirmation:${reset}"
    read -s KEY_CONFIRM
    echo

    if [ "$KEY" == "$KEY_CONFIRM" ]; then
      echo "$KEY" > $VAULT_SECRET
      break
    else
      echo -e "${red}The vault key do not match.${reset}"
    fi
  done
fi

# Run Ansible playbook
cd $ANSIBLE_DIR
echo -e "${green}Running ansible playbook...${reset}"
ansible-playbook --vault-password-file $VAULT_SECRET $ANSIBLE_DIR/main.yml --become
