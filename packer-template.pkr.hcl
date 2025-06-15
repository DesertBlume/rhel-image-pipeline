packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

variable "iso_url" {
  type    = string
  default = "rhel-8.1-x86_64-dvd.iso"
}

source "virtualbox-iso" "rhel_gui" {
  guest_os_type     = "RedHat_64"
  iso_url           = var.iso_url
  iso_checksum      = "none"
  ssh_username      = "root"
  ssh_password      = "packer123"
  ssh_wait_timeout  = "30m"
  boot_wait         = "5s"
  shutdown_command  = "shutdown -P now"
  disk_size         = 20480
  headless          = false
  vm_name           = "rhel-gui-lab"

  boot_command = [
    "<tab> inst.text inst.ks=hd:fd0:/rhel8-ks.cfg console=tty0 <enter>"
  ]

  floppy_files = [
    "rhel8-ks.cfg"
  ]
}

build {
  sources = ["source.virtualbox-iso.rhel_gui"]

  provisioner "shell" {
    script = "setup.sh"
  }
}
