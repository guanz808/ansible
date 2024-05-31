# Run Updates
apt-get update && apt-get install -y
apt install wget -y

# run pre.sh
cd ~
rm -f pre.sh && wget -O pre.sh https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh && chmod +x pre.sh && ./pre.sh

# run setup.sh
rm -f setup.sh
wget -O setup.sh https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh && chmod +x setup.sh && ./setup.sh

# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles