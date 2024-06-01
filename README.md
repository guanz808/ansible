# Run Updates
apt-get update && apt-get install -y  
apt install curl git -y  

# run pre.sh
cd ~  
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/pre.sh)"

# run setup.sh
#rm -f setup.sh
#curl -o setup.sh https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh && chmod +x setup.sh && ./setup.sh

Option 1 
```
git clone https://github.com/guanz808/ansible.git
cd ~/ansible
chmod +x setup.sh 
./setup.sh
```
Option 2 
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/guanz808/ansible/main/setup.sh)"
```


# Notes:
Add <userName> to vault

# References
https://github.com/techdufus/dotfiles