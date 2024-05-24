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

echo "creating user jiadmin account"
adduser jiadmin
usermod -aG sudo jiadmin
su jiadmin

cd ~
git clone https://github.com/guanz808/ansible.git
cd ~/ansible

chmod + ./setup.sh
# if running in a container run
sudo bash ./setup.sh