# Run Updates
apt-get update && apt-get install -y
apt install wget

# run pre.sh
cd ~
wget https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh && chmod +x pre.sh

# run setup.sh
wget https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh && chmod +x setup.sh

# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles