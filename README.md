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
# run setup.sh (skip this step if running in WSL)
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/setup)"
```

# to update rerun after the initial setup
setup

# To run install a role using a tag(s)
```
setup -t <role>
setup -t "<role1>,<role2>"
```

# Notes:
1. If running in WSL change the font to CaskaydiaCove Nerd Font  
 - Terminal > Settings > Profiles > <distro> Additional Settings > Appearance > Font face
2. To install the Tmux plugins: ctrl+b I  

# Troubleshooting
1. To fix:  ERROR: Ansible could not initialize the preferred locale: unsupported locale setting
    ```
    sudo apt-get install locales
    sudo locale-gen "en_US.UTF-8"
    ```

# References
https://github.com/techdufus/dotfiles