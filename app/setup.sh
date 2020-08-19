#!/bin/bash

# setting up
# This provision script is to be run on your own OS and it sets up the vm but automating the provision script exectution within the vm

# this command allows a synchronisation between the OS and VM: In this case we are placing /app folder in the /home/ubuntu/ directory
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Desktop/nginx_sample_code/nodejs-aws-deploy/app ubuntu@ec2-52-211-100-82.eu-west-1.compute.amazonaws.com:/home/ubuntu/
echo "synchronised between OS and VM successfull"

# this command enters the vm upon synchronising the /app file above and creates a new directory called "environment"
ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@ec2-52.211.100.82.eu-west-1.compute.amazonaws.com -i $ mkdir environment
echo "successfully created environment directory within vm"

# this command synchronises the /app folder into the newly made environment folder above
scp -i ~/.ssh/DevOpsStudents.pem -r ~/Desktop/nginx_sample_code/nodejs-aws-deploy/app ubuntu@ec2-52.211.100.82.eu-west-1.compute.amazonaws.com:/home/ubuntu/environment
echo "sucessfully synchronised the /app folder in environment"

# this command navigates to the newly placed app folder in environment and calls for the provision.sh file
ssh -i ~/.ssh/DevOpsStudents.pem ubuntu@ec2-52.211.100.82.eu-west-1.compute.amazonaws.com -i $ ./environment/app/

# # gives the provision.sh file executable privellages
# chmod +x provision.sh
#
# # runs the provision.sh file - which begins downloading all the dependencies that mean our app runs on port 80
# ./provision.
