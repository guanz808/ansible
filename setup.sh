#!/bin/bash

# Clone the Ansible repository
cd ~
git clone https://github.com/guanz808/ansible.git
cd ~/ansible

# Make the setup script executable
chmod +x ./setup.sh

# Run the setup script (use sudo if in a container)
if [ -f /.dockerenv ]; then
  sudo bash ./setup.sh
else
  bash ./setup.sh
fi

# Add the key to the vault_key file (replace "key" with your actual key)
echo "key" > ~/ansible/.vault_key
cat ~/ansible/.vault_key

# Run the Ansible playbook
ansible-playbook main.yml --become