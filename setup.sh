#!/bin/bash

# Prompt for Key
read -p "Enter the vault key: " key

if [ ! -d ~/ansible ]; then
  # Command to run if the directory doesn't exist
  echo "Directory ~/ansible not found. Running specific command..."
  cd ~
  git clone https://github.com/guanz808/ansible.git
fi

cd ~/ansible

# Add the key to the vault_key file (replace "key" with your actual key)
echo "$key" > ~/ansible/.vault_key
cat ~/ansible/.vault_key

# Run the setup script (use sudo if in a container)
if [ -f /.dockerenv ]; then
  # Run the Ansible playbook
  sudo ansible-playbook main.yml --become
else
  # Run the Ansible playbook
  ansible-playbook main.yml --become
fi