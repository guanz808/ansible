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
1. To install the Tmux plugins: ctrl+b I  

# References
https://github.com/techdufus/dotfiles