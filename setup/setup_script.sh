#!/bin/bash

# sudo apt-get install software-properties-common -y
# sudo apt-get install tree -y
# sudo apt-add-repository--yes--update ppa:ansible/ansible
# sudo apt-get install ansible -y
# sudo apt-get install sshpass -y
#
# echo "All ansible dependencies have been installed"
#
#
# cd /etc/ansible
#
# echo "[web]
# 192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
#
# echo  "[db]
# 192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
#
# echo  "[aws]
# 192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> hosts
#
# cd ..
#
#
# echo "IP addresses have been initiated"

#go into web server
# sshpass -p 'vagrant' ssh vagrant@192.168.33.10
# sudo apt-get update -y
# sudo apt-get upgrade -y
# echo "web is done"
# exit
# 
# #go into dev server
# sshpass -p 'vagrant' ssh vagrant@192.168.33.11
# sudo apt-get update -y
# sudo apt-get upgrade -y
# echo "db is done"
# exit
# EOF
#
# ssh vagrant@192.168.33.12 << EOF

echo "pinging to check if ips are working"

ansible all -m ping

cd /home/vagrant/ansible

ansible-playbook copy_app.yaml

echo "App has been successfully copied to web virtual machine"

ansible-playbook db_playbook.yaml

echo "db has been provisoned"

ansible-playbook test.yaml

"app has been successfully provisioned"

EOF
