
!#/bin/sh
# Download and install the prerequisite
sudo apt update && sudo apt install -y software-properties-common python3-pip
# Install Ansible
sudo apt install -y ansible
# Verify current ansible version
ansible --version

