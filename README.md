su
apt update && apt upgrade -y
apt -y install software-properties-common curl sudo adduser 
apt-add-repository ppa:ansible/ansible -y
apt update -y
apt install ansible -y
ansible --version


#ansible-playbook base.yml -i inventory/hosts -e @group_vars/vault.yml --ask-vault-pass --vault-password-file=ansible-vault.pass
#ansible-playbook base.yml -i inventory/hosts -e @group_vars/vault.yml --vault-password-file=.vault_key
ansible-playbook base.yml
ansible-playbook base.yml --become --become-user jiadmin