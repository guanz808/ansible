apt update && apt upgrade -y
apt install git -y
cd ~
git clone https://github.com/guanz808/ansible.git
cd ~/ansible

chmod + ./setup.sh
# if running in a container run
bash ./setup.sh