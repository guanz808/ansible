#!/bin/bash

###sudo apt-add-repository -y ppa:ansible/ansible -y
###sudo apt-get update -y
###sudo apt install -y ansible
###
###sudo locale-gen "en_US.UTF-8"
###
###cd ~/ansible
###echo "Add the key to the .vault_key file"

#ansible-playbook main.yml --become

#!/bin/bash

# Prompt for username
read -p "Enter desired username: " username

# Check if we're in a container
if [ -f /.dockerenv ]; then
  # Container environment, use sudo for installation
  echo "Detected container environment. Using sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    git \
    vim \
    adduser \
    sudo \
    locales \
    unzip
  
  clear
  echo "Changing root password (enter twice)"
  passwd root
  sudo locale-gen "en_US.UTF-8"
else
  # Not a container, use regular apt-get
  echo "Not detected as a container environment. Skipping sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    git \
    vim
fi

clear

# Check if user already exists using id command (more efficient)
if id "$username" >/dev/null 2>&1; then
  echo "User '$username' already exists."
  su - "$username"
  exit 1  # Indicate failure with non-zero exit code
else
  echo "Creating user account for '$username'"
  adduser "$username"  
  usermod -aG sudo "$username"     # Add to sudo group

  # Grant immediate access to the new account (if needed)
  su - "$username"
fi