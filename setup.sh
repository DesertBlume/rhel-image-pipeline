#!/bin/bash
set -e

echo "[Setup] Registering system with Red Hat..."
subscription-manager register --username haja0013@algonquinlive.com --password 'rd*37BL-73hh_10' --auto-attach
subscription-manager refresh

echo "[Setup] Installing Ansible, Git, and basic tools..."
dnf install -y git ansible net-tools bind-utils vim

echo "[Setup] Cloning lab repository and running Ansible playbook..."
cd /root   # ensure we are in a writeable directory
git clone https://github.com/DesertBlume/rhel-image-pipeline.git
cd rhel-image-pipeline/playbook    # adjust path to playbooks directory if different
# Run ansible-playbook on localhost (as this script is run as root, we have full privileges)
ansible-playbook -i "localhost," -c local lab_setup.yml

echo "[Setup] Ansible playbook run completed."

# (Optional) Unregister to prepare the image as a template (avoid subscription conflicts in clones)
subscription-manager unregister || true
subscription-manager clean || true

echo "[Setup] Done. Shutting down..."
