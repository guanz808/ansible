#!/bin/bash

su
apt update && apt upgrade -y
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt update -y
apt install ansible -y
ansible --version

cd /etc/ansible
sudo curl -o ansible.cfg https://raw.githubusercontent.com/guanz808/ansible/master/ansible.cfg
# Review ansible.cfg content
sudo curl -o base.yml https://raw.githubusercontent.com/guanz808/ansible/master/base.yml
# Review base.yml content
sudo curl -o hosts https://raw.githubusercontent.com/guanz808/ansible/master/hosts
# Review hosts content

ansible-playbook /etc/ansible/base.yml
