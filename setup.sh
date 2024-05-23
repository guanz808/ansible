#!/bin/bash
sudo apt update && apt upgrade -y
sudo apt -y install \
- software-properties-common \
- git \
- curl \
- sudo \
- adduser \
- vim 

sudo apt-add-repository -y ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt install -y ansible

cd ~/ansible
ansible-playbook main.yml