# Run Updates
apt-get update && apt-get install -y
apt install curl wget -y

# run pre.sh
cd ~
curl -o pre.sh https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh && chmod +x pre.sh && ./pre.sh

# run setup.sh
rm -f setup.sh
curl -o setup.sh https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh && chmod +x setup.sh && ./setup.sh

# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles