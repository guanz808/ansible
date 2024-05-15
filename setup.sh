#!/bin/bash

su
apt update && apt upgrade -y
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt update -y
apt install ansible -y
ansible --version

curl -o /etc/ansible/ansible.cfg https://raw.githubusercontent.com/guanz808/ansible/master/ansible.cfg
curl -o /etc/ansible/base.yml https://raw.githubusercontent.com/guanz808/ansible/master/base.yml
curl -o /etc/ansible/hosts https://raw.githubusercontent.com/guanz808/ansible/master/hosts

ansible-playbook /etc/ansible/base.yml
