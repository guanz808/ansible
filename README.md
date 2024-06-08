# Run Updates
```bash
apt update && apt install -y  
apt install curl git -y  
```
# run pre.sh
```bash
cd ~  
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh)"
``` 
# run setup.sh
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/setup)"
```

# To run install a role using a tag(s)
```
setup -t <role>
setup -t "<role1>,<role2>"
```

# Notes:
1. Add <userName> to vault
1. neofetch config.conf file not working  
~~1. add .zshenv to ~ change to symlink~~
~~1. set the order for the roles to run~~
1. editing the setup file in github causes a git pull merg conflict on the remote

# References
https://github.com/techdufus/dotfiles