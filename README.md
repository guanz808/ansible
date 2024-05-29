# Check if we're in a container
if [ -f /.dockerenv ]; then
  # Container environment, use sudo for installation
  echo "Detected container environment. Using sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    git \
    vim \
    adduser \
    sudo \
    locales

  echo "change root password"
  passwd root

else
  # Not a container, use regular apt-get
  echo "Not detected as a container environment. Skipping sudo for installation."
  apt-get update && apt-get install -y \
    software-properties-common \
    git \
    vim
fi

echo "creating user <userName> account"
adduser <userName>
usermod -aG sudo <userName>
su <userName>

cd ~
git clone https://github.com/guanz808/ansible.git
cd ~/ansible

chmod + ./setup.sh
# if running in a container run
sudo bash ./setup.sh

# add the key to the .vault_key file
echo "key" > ~/ansible/.vault_key
cat ~/ansible/.vault_key

# run ansible-playbook
ansible-playbook main.yml --become

# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles