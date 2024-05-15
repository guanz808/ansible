#!/bin/bash

su
apt update && apt upgrade -y
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt update -y
apt install ansible -y
ansible --version

source_url="https://raw.githubusercontent.com/guanz808/ansible/master/"
target_dir="/etc/ansible"

# Loop through filenames (adjust these as needed)
files=(ansible.cfg base.yml hosts)

for filename in "${files[@]}"; do
  sudo curl -o "$target_dir/$filename" "$source_url/$filename"
done
ansible-playbook /etc/ansible/base.yml
