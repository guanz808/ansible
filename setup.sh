#!/bin/bash

#su
#cd ~
#apt update && apt upgrade -y
#apt -y install software-properties-common curl
#apt-add-repository ppa:ansible/ansible -y
#apt update -y
#apt install ansible -y
#ansible --version


# Check and delete /etc/ansible/ansible.cfg
if [ -f /etc/ansible/ansible.cfg ]; then
  rm /etc/ansible/ansible.cfg
  echo "Deleted /etc/ansible/ansible.cfg"
else
  echo "/etc/ansible/ansible.cfg does not exist."
fi

# Check and delete /etc/ansible/base.yml
if [ -f /etc/ansible/base.yml ]; then
  rm /etc/ansible/base.yml
  echo "Deleted /etc/ansible/base.yml"
fi

# Check and delete /etc/ansible/hosts
if [ -f /etc/ansible/hosts ]; then
  rm /etc/ansible/hosts
  echo "Deleted /etc/ansible/hosts"
fi

curl -o /etc/ansible/ansible.cfg https://raw.githubusercontent.com/guanz808/ansible/master/ansible.cfg
curl -o /etc/ansible/base.yml https://raw.githubusercontent.com/guanz808/ansible/master/base.yml
curl -o /etc/ansible/hosts https://raw.githubusercontent.com/guanz808/ansible/master/hosts

ansible-playbook /etc/ansible/base.yml
