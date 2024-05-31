#!/bin/bash

# Prompt for Key
read -p "Enter the vault key: " key

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

if [[ $(stat -c %s ~/ansible/.vault_key) -gt 0 ]]; then
  echo "~/ansible/.vault_key has content."
else
  echo "~/ansible/.vault_key is empty or doesn't exist."
fi

# Add the key to the vault_key file
echo "$key" > ~/ansible/.vault_key

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