#!/bin/bash

sudo apt -y install \
- software-properties-common \
- git \
- curl \
- sudo \
- adduser \
- vim 

#!/bin/bash

sudo apt update && apt upgrade -y

# Check if we're in a container
if [ -f /.dockerenv ]; then
  # Container environment, use sudo for installation
  echo "Detected container environment. Using sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    vim \
    adduser \
    sudo \
    locales
else
  # Not a container, use regular apt-get
  echo "Not detected as a container environment. Skipping sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    git \
    vim
fi



sudo apt-add-repository -y ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt install -y ansible

cd ~/ansible
ansible-playbook main.yml