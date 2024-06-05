# Run Updates
```bash
apt-get update && apt-get install -y  
apt install curl git -y  
```
# run pre.sh
```bash
cd ~  
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh)"
``` 
# run setup.sh
Option 1 
```bash
git clone https://github.com/guanz808/ansible.git
cd ~/ansible
chmod +x setup.sh 
./setup.sh
```
Option 2 
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh)"
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