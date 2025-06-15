# RHEL 8 Automated Lab Build

This repository contains everything needed to build, configure, and deploy a fully automated Red Hat Enterprise Linux 8 virtual machine using:

- **Packer** to automate the VM creation
- **Kickstart** for unattended OS installation
- **Ansible** for post-install configuration (networking, users, services)

---

## 📦 Components

```
rhel-setup-playbook/
├── rhel-setup-playbook.yml      # Main Ansible playbook
├── inventory                    # Ansible hosts file
└── templates/                   # Jinja2 config templates
    ├── ifcfg-ens224.j2
    └── named.conf.j2

http/
├── ksm1.cfg                     # Kickstart file for Packer ISO
```

---

## 🚀 Workflow

### 1. Create Custom ISO

Run from WSL/Linux:
```bash
mkisofs -o /mnt/c/Users/Home/Desktop/packer-rhel-lab/iso/rhel8.1-playauto-min.iso \
  -b isolinux/isolinux.bin -c isolinux/boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -R -J -v -T -V "RHEL-8-1-0-BaseOS-x86_64" .
```

### 2. Build with Packer
```bash
packer build play-min-rhel8-base.pkr.hcl
```

### 3. SSH Into VM
```bash
ssh root@172.16.30.48
```

### 4. Run Ansible Playbook
```bash
cd rhel-setup-playbook
ansible-playbook -i inventory rhel-setup-playbook.yml
```

---

## ✅ Features

- Preconfigured network adapters (DHCP + static)
- Configurable hostname
- DNS server setup (BIND)
- OpenSSH server install and start
- Admin user creation via Ansible

---

## 🔒 Notes

- Make sure to `.gitignore` large files like `.iso`, `packer_cache/`, and `output-*`
- Use private repositories or Ansible Vault for secrets

---

Created by Hmoad Hajali for CST8246 Labs 🔧
