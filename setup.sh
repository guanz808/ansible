#!/bin/bash

sudo apt-add-repository -y ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt install -y ansible

sudo locale-gen "en_US.UTF-8"

cd ~/ansible
echo "Add the key to the .vault_key file"

#ansible-playbook main.yml --become