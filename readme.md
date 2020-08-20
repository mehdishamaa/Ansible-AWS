https://medium.com/@mehdishamaa/how-to-provision-an-ec2-instance-using-ansible-a681f0024aad


- Why use Ansible to provision our EC2 instances?
Ansible is a powerful tool — along with Puppet and Chef it is one of the most widely-used automation engines. Ansible allows us to build our infrastructure using infrastructure as code, drastically reducing the time spent provisioning instances.



# Prerequisites
 - A couple of prerequisites are needed before we start writing our Ansible files:
 - An AWS account
 - Ansible
 - Python
 - Boto
 
 
Firstly, open a terminal on a Linux based system. Install Ansible and its prerequisites using the following commands:
`sudo apt-get install software-properties-common`
`sudo apt-add-repository ppa:Ansible/Ansible`
`sudo apt-get update`
`sudo apt-get install Ansible`


2. Next install Python:
`sudo apt-get update`
`sudo apt-get install python3.6`


3. Install Boto:
`sudo apt install python3-pip`
`pip install Boto`


4. Now that we have all prerequisites installed, we need to create a key to be able to SSH into our instance:
`ssh-keygen -t rsa -b 4096 -f ~/.ssh/<Your_Name>_aws`

5. Next we create our Ansible directory structure:
`mkdir -p AWS_Ansible/group_vars/all/`
`cd AWS_Ansible`
`touch playbook.yml`

6. We now need to create an Ansible vault file to store our AWS access and secret keys:
a`nsible-vault create group_vars/all/pass.yml`
When prompted, create a password for your vault.

7. Next, plug in your AWS access and secret keys to the pass.yml file you have just created:
`ansible-vault edit group_vars/all/pass.yml`
(You may have to decrypt and re-encrypt the file before doing this).

8. Use sudo nano playbook.yml to edit your playbook with the following code:



# AWS playbook
---

- hosts: localhost
  connection: local
  gather_facts: False

  vars:
    key_name: <Your_Name>_aws #(The key you made earlier)
    region: eu-west-1
    image: # AMI id found on AWS.
    id: "web-app"
    sec_group: "{{ id }}-sec"

  tasks:

    - name: Facts
      block:

      - name: Get instances facts
        ec2_instance_facts:
          aws_access_key: "{{ec2_access_key}}"
          aws_secret_key: "{{ec2_secret_key}}"
          region: "{{ region }}"
        register: result

      - name: Instances ID
        debug:
          msg: "ID: {{ item.instance_id }} - State: {{ item.state.name }} - Public DNS: {{ item.public_dns_name }}"
        loop: "{{ result.instances }}"

      tags: always


    - name: Provisioning EC2 instances
      block:

      - name: Upload public key to AWS
        ec2_key:
          name: "{{ key_name }}"
          key_material: "{{ lookup('file', '~/.ssh/{{ key_name }}.pub') }}"
          region: "{{ region }}"
          aws_access_key: "{{ec2_access_key}}"
          aws_secret_key: "{{ec2_secret_key}}"

      - name: Create security group
        ec2_group:
          name: "{{ sec_group }}"
          description: "Sec group for app {{ id }}"
          # vpc_id: 12345
          region: "{{ region }}"
          aws_access_key: "{{ec2_access_key}}"
          aws_secret_key: "{{ec2_secret_key}}"
          rules:
            - proto: tcp
              ports:
                - 22
              cidr_ip: 0.0.0.0/0
              rule_desc: allow all on ssh port
        register: result_sec_group

      - name: Provision instance(s)
        ec2:
          aws_access_key: "{{ec2_access_key}}"
          aws_secret_key: "{{ec2_secret_key}}"
          key_name: "{{ key_name }}"
          id: "{{ id }}"
          group_id: "{{ result_sec_group.group_id }}"
          image: "{{ image }}"
          instance_type: t2.micro
          region: "{{ region }}"
          wait: true
          count: 1
          instance_tags:
            Name: Eng57.<First>.<L>.WebApp

      tags: ['never', 'create_ec2']

      tags: ['never', 'create_ec2']
9. Run this playbook. Your AWS instance should now be set up and running!
