#!/bin/bash
#apt update && apt upgrade -y
#apt -y install software-properties-common curl sudo adduser vim locales git 

function ubuntu_setup() {
  if ! dpkg -s ansible >/dev/null 2>&1; then
    _task "Installing Ansible"
    _cmd "sudo apt-get update"
    _cmd "sudo apt-get install -y software-properties-common"
    _cmd "sudo apt-add-repository -y ppa:ansible/ansible"
    _cmd "sudo apt-get update"
    _cmd "sudo apt-get install -y ansible"
    _cmd "sudo apt-get install python3-argcomplete"
    _cmd "sudo activate-global-python-argcomplete3"
  fi
  if ! dpkg -s python3 >/dev/null 2>&1; then
    _task "Installing Python3"
    _cmd "sudo apt-get install -y python3"
  fi
  if ! dpkg -s python3-pip >/dev/null 2>&1; then
    _task "Installing Python3 Pip"
    _cmd "sudo apt-get install -y python3-pip"
  fi
  if ! pip3 list | grep watchdog >/dev/null 2>&1; then
    _task "Installing Python3 Watchdog"
    _cmd "pip3 install watchdog"
  fi
}