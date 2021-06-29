
#!/bin/sh
# Download and install the prerequisite
sudo apt update && sudo apt install -y software-properties-common python3-pip
# Install Ansible
sudo apt install -y ansible
# Verify current ansible version
ansible --version
# Copy the ssh key to authorise the connection to this machine
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# Set the host to this machine, ie localhost
cat Ansible/hosts | sudo tee -a /etc/ansible/hosts

