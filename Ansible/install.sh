
#!/bin/sh
# Set the prerequisite
sudo amazon-linux-extras enable ansible2
# Install Ansible
sudo yum install -y ansible
# Verify current ansible version
ansible --version
# Copy the ssh key to authorise the connection to this machine
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# Set the host to this machine, ie localhost
cat Ansible/hosts | sudo tee -a /etc/ansible/hosts

