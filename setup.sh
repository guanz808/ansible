#!/bin/bash

# Specify the file to check
file_path="~/ansible/.vault_key"  # Replace with your actual file path

# Check if the file exists and is not empty
if [[ -f "$file_path" && -s "$file_path" ]]; then
  # The file exists and has content
  echo "File '$file_path' has content. Running task for non-empty files..."
  # Add your commands for non-empty files here (e.g., processing the content)
  #<your_command_for_non_empty_files>
else
  # The file either doesn't exist or is empty
  echo "File '$file_path' is empty or doesn't exist. Running task for empty files..."
  # Add your commands for empty files here
  read -p "Enter the vault key: " key
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