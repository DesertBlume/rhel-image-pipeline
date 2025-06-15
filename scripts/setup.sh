#!/bin/bash

echo "[+] Updating system and installing git..."
dnf install -y git

echo "[+] Cloning Ansible project from GitHub..."
git clone https://github.com/DesertBlume/rhel-image-pipeline.git

echo "[+] Moving into playbook directory..."
cd rhel-image-pipeline/rhel-setup-playbook || exit 1

echo "[+] Installing Ansible if missing..."
subscription-manager repos --enable ansible-2.9-for-rhel-8-x86_64-rpms

dnf install -y ansible

)

ssh-keyscan -H 172.16.30.48 >> ~/.ssh/known_hosts


echo "[+] Running Ansible playbook..."
ansible-playbook -i inventory rhel-setup-playbook.yml
