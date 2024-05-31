# Run Updates
apt-get update && apt-get install -y
apt install curl wget git -y

# run pre.sh
cd ~
curl -o pre.sh https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh && chmod +x pre.sh && ./pre.sh

# run setup.sh
rm -f setup.sh
curl -o setup.sh https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh && chmod +x setup.sh && ./setup.sh

git clone https://github.com/guanz808/ansible.git
git pull


# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles