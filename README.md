# Run Updates
```bash
apt update && apt install -y  
apt install curl git -y  
```
# run pre.sh
```bash
cd ~  
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/upgrade/pre.sh)"
``` 
# run setup.sh
Option 1 
```bash
git clone https://github.com/guanz808/ansible.git
cd ~/ansible
chmod +x setup 
./setup
```
Option 2 
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/upgrade/setup)"
```


# Notes:
1. Add <userName> to vault
1. neofetch config.conf file not working  
~~1. add .zshenv to ~ change to symlink~~
1. add symlinks to files
1. zsh history file not working
1. set the order for the roles to run

# References
https://github.com/techdufus/dotfiles