### Infrastructure as Code IaC
- IaC is used to speed up the process of configuration management or orchestration
#### Ansible
- Infrastructure automation tool for configuration management
- Connects via ssh

#### Advantages of Ansible
Ansible doesn’t use agents, and its code is written in YAML in the form of Ansible Playbooks, so configurations are very easy to understand and deploy.

- simple
- Agentless
- IT automation

#### Practical example
- create 3 instances
- One Ansible controller instance - that will dictate the configuration of the two other instances in our network
The controller virtual machine is the vm that has Ansible installed on it and the other instances do not require Ansible to be downloaded on them (Agentless)

Ubuntu 16.04 vm - webApp
Ubuntu 16.04 vm - db

### creating controller 
we want to install ansible on the aws virtual machine we have created using the vagrantfile
look at the system of ansible 
how to create host entries tell the controller which ips to communicate with 

### installing ansible on controller 
- ssh into aws virtual machine 
- sudo apt-get install software-properties-common -y
- sudo apt-get update
	sudo apt-get install software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install ansible
sudo apt-get install tree

cd etc/ansible - default location for files 

ansible "name of vm" -m ping - code to communicate to other vms 

192.168.33.10 - web
192/168.33.11 - db 

[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
[aws]
192.168.33.12 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant


this how we connect the controller to the vms 

to ssh into the vms 
ssh vagrant@192.168.33.10

ping machines with ansible command

# Instructions 

1) First run the following up to run all the machines


vagrant up 


2) Enter each VM update the packages:


vagrant ssh db
sudo apt-get update
exit

# repeat steps but with app and aws 
vagrant ssh app 
vagrant ssh aws 


3) Enter the AWS and run this



sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get install ansible -y # install ansible 
sudo apt-get install tree


4) Enter /etc/ansible folder


cd /etc/ansible tree 
### ansible.cfg, hosts and roles should appear
 

5) test no connected to app and 


ping 192.168.33.11
ping 192.168.33.10 # testing connection with Db and app


6) Create Host entries 


cd ../../etc/ansible 
sudo nano hosts

# copy the following inside hosts
[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant




7) vagrant ssh into the other vm


ssh vagrant@192.168.33.10
ssh vagrant@192.168.33.11

# you will be asked to add a new ECDSA fingerprint. Password is vagrant 
# After adding these new fingerprints, sudo apt-get update
sudo apt-get update 



8) ping the connections back in aws controller

ansible all -m ping


### Ansible Ad Hoc Commands 
ad hoc commads are one line commands that provide the functionality of ansible 
An Ansible ad-hoc command uses the /usr/bin/ansible command-line tool to automate a single task on one or more managed nodes. Ad-hoc commands are quick and easy, but they are not reusable

ad hoc commands - easy to use and gives a lot of information about a particular virtual machine. we can gather this information by gathering from the controller as oppose to the ssh'ing in to the vm itself 


### example of ad hoc commands

```
ansible web -a "date"

ansible db -a "uname -a"

ansible all -m shell -a "ls -a"

ansible all -a "free"

ansible atlanta -m copy -a "src=/etc/hosts dest=/tmp/hosts"

ansible all -m shell -a 'echo hello world'

ansible webservers -m file -a "dest=/srv/foo/a.txt mode=600"

ansible all -m shell -a "hostname -I" - returns ip address of vm
ansible all -m shell -a "ifconfig" - returns all ip addresses of vm

ansible all -m shell -a "uptime" - uptime of instances

ansible all -m shell -a "env" - environment variables of instances

ansible all -m shell -a "free" - returns free space of instances 

```

### Ansible playbooks 

Playbooks are Ansible’s configuration, deployment, and orchestration language.
written in YAML file ext is .yml or .yaml (yet another markup language)

YAML file start with three dashes (---)
Kubernetes uses YAML
Docker compose uses YAML
widely used within the realm of infrastructure as code 

we create the playbook within the Controller instances (the vm with ansible installed)

### difference between ad hoc and playbook

the playbook operates just like a bash script but has more powerful functionality
automates the tasks we need to carry out in multiple locations 

command to run playbook:
n
m
