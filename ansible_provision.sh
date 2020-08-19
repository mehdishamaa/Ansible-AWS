#!/bin/bash


# this provision script should be run on the controller vm (aws in our case)

sudo apt update -y

sudo apt install software-properties-common -y

sudo apt-add-repository --yes --update ppa:ansible/ansible

sudo apt-get install tree -y

sudo apt install ansible -y

echo "well done youve got this far"

cd /etc/ansible

sudo su

sudo echo "[web]" >> /etc/ansible/hosts

sudo echo "192.168.0.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> /etc/ansible/hosts

sudo echo "[db]" >> /etc/ansible/hosts

sudo echo "192.168.0.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> /etc/ansible/hosts

sudo echo "[aws]" >> /etc/ansible/hosts

sudo echo "192.168.0.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant" >> /etc/ansible/hosts

sudo echo "host_key_checking = False" >> /etc/ansible/ansible.cfg

echo "well done you have got this far now"

ansible all -m ping
