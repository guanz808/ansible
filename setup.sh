#!/bin/bash

su
apt update && apt upgrade -y
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible -y
apt update -y
apt install ansible -y
ansible --version

curl -o ansible.cfg https://github.com/guanz808/ansible/master/ansible.cfg -o /etc/ansible
curl -o base.yml https://github.com/guanz808/ansible/master/base.yml -o /etc/ansible
curl -o hosts https://github.com/guanz808/ansible/master/hosts -o /etc/ansible

ansible-playbook /etc/ansible/base.yml
