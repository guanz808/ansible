#!/bin/bash

# Specify the file to check (consider using a variable)
vault_key_file="~/ansible/.vault_key"

# Check if the vault key file exists
if [[ -f "$vault_key_file" ]]; then
  # Check if the file has content
  if [[ -s "$vault_key_file" ]]; then
    echo "File '$vault_key_file' has content. Using existing vault key..."
  else
    echo "File '$vault_key_file' is empty. Enter the vault key: "
    read -p "" key  # Read key without echoing the character
  fi
# Prompt for Key
#read -p "Enter the vault key: " key

sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
ansible --version

if [ ! -d ~/ansible ]; then
  # Directory doesn't exist, clone the repository
  echo "Directory ~/ansible not found. Cloning the repository..."
  cd ~
  git clone https://github.com/guanz808/ansible.git
  cd ~/ansible
else
  # Directory exists, handle existing content (optional)
  echo "Directory ~/ansible already exists."
  cd ~/ansible
  git reset --hard origin/main
fi

if [ -n "$key" ]; then
  echo "Variable 'key' has a value: '$key'"
  # Add your commands to run if the variable has a value here
  echo "$key" > ~/ansible/.vault_key
fi

# Add the key to the vault_key file
#echo "$key" > ~/ansible/.vault_key

ansible-playbook main.yml --become

# Run the setup script (use sudo if in a container)
#if [ -f /.dockerenv ]; then
#  # Run the Ansible playbook
#  sudo ansible-playbook main.yml --become
#else
#  # Run the Ansible playbook
#  ansible-playbook main.yml --become
#fi

rm pre.sh
rm setup.sh