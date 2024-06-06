#!/bin/bash

# Colors (use predefined variables)
red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

# Paths
VAULT_SECRET="$HOME/ansible/.vault_key"
ANSIBLE_DIR="$HOME/ansible"
script_path="~/ansible/setup.sh"

# Install Ansible
if ! command -v ansible &> /dev/null
then
    echo -e "${green}Ansible not found, installing now...${reset}"
    sudo apt-add-repository ppa:ansible/ansible -y
    sudo apt update -y
    sudo apt install ansible -y
else
    echo -e "${green}Ansible is already installed.${reset}"
fi
#ansible --version

# Clone Ansible repository (if not already present) #### 6/5/24 ####
if [ ! -d $ANSIBLE_DIR ]; then
  echo -e "${green}Directory $ANSIBLE_DIR not found. Cloning the repository...${reset}"
  git clone --quiet -b upgrade https://github.com/guanz808/ansible.git $ANSIBLE_DIR
else
  echo -e "${green}Directory $ANSIBLE_DIR already exists. Updating...${reset}"
  #cd $ANSIBLE_DIR
  #git pull origin upgrade $ANSIBLE_DIR
  git -C $ANSIBLE_DIR pull origin upgrade --quiet 
fi


# Add the ~/ansible/setup.sh to the Path
# Check if the script exists
if [ ! -f "$script_path" ]; then
  echo "Error: Script '$script_path' does not exist!"
  exit 1
fi

# Check if the script path is already in PATH
if echo $PATH | grep -q "$script_path"; then
  echo "$script_path is already in your PATH."
else
  # Add the script path to PATH
  export PATH="$PATH:$script_path"
  echo "$script_path added to your PATH."

  # Add the line to permanently modify PATH (optional)
  # Uncomment the following line to add the path to your shell profile
  # echo "export PATH=\$PATH:$script_path" >> ~/.bashrc
  chmod +x setup.sh 
fi

echo "PATH is now: $PATH"


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
#ansible-playbook --vault-password-file $VAULT_SECRET $ANSIBLE_DIR/main.yml --become
ansible-playbook $ANSIBLE_DIR/main.yml #--become
