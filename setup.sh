#!/bin/bash
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update -y
sudo apt install ansible -y
ansible --version

if [ ! -d ~/ansible ]; then
  # Directory doesn't exist, clone the repository
  echo "${GREEN}Directory ~/ansible not found. Cloning the repository...${RESET}"
  cd ~
  git clone https://github.com/guanz808/ansible.git
  cd ~/ansible
else
  # Directory exists, handle existing content (optional)
  echo "${GREEN}Directory ~/ansible already exists.${RESET}"
  cd ~/ansible
  #git reset --hard origin/main
  git pull
  #git fetch --all
fi

# Check if the main vault key file exists
if [ ! -f ~/ansible/.vault_key ]; then
  # Check if the temporary key file exists
  if [ -f ~/ansible/.vault_key_tmp ]; then
    echo "Renaming temporary vault key to main key..."
    # Move the temporary file to the main key location
    cp ~/ansible/.vault_key_tmp ~/ansible/.vault_key
    # Prompt for Key
    read -p "Enter the vault key: " key
  else
    echo "No vault key found."
  fi
else
  echo "Main vault key already exists."
fi

if [[ $(stat -c %s ~/ansible/.vault_key) -gt 0 ]]; then
  echo "~/ansible/.vault_key has content."
else
  echo "~/ansible/.vault_key is empty or doesn't exist."
  # Add the key to the vault_key file
  echo "$key" > ~/ansible/.vault_key
fi

echo "${GREEN}getting key vault value${RESET}"
cat ~/ansible/.vault_key

echo "${GREEN}Running ansible playbook${RESET}"
#ansible-playbook main.yml --become