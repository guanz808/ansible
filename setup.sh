#!/bin/bash

# Prompt for Key
read -p "Enter the vault key: " key

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
  # You can add logic here to handle existing content (e.g., prompt user)
fi

# Add the key to the vault_key file
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