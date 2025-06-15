packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

source "vmware-iso" "rhel8" {
  iso_url            = "C:/Users/Home/Desktop/packer-rhel-lab/iso/rhel8.1-auto-ks.iso"
  iso_checksum       = "none"

  communicator       = "ssh"
  ssh_username       = "root"
  ssh_password       = "abc"
  ssh_timeout        = "30m"

  vm_name            = "rhel8-base"
  guest_os_type      = "rhel8-64"
  disk_size          = 40960
  memory             = 8000
  cpus               = 2
  output_directory   = "output-rhel8-base"

  headless           = false
  boot_wait          = "0s"
  boot_command       = []
  shutdown_command   = "shutdown -P now"

  vmx_data = {
    "ethernet0.present"        = "TRUE"
    "ethernet0.connectionType" = "custom"
    "ethernet0.vnet"           = "VMnet8"
    "ethernet0.virtualDev"     = "vmxnet3"

    "ethernet1.present"        = "TRUE"
    "ethernet1.connectionType" = "custom"
    "ethernet1.vnet"           = "VMnet2"
    "ethernet1.virtualDev"     = "vmxnet3"

    "keyboard.present"         = "TRUE"
    "mouse.present"            = "FALSE"
    "gui.exitonCLIHLT"         = "TRUE"
    "bios.bootDelay"           = "8000"
  }
}

build {
  sources = ["source.vmware-iso.rhel8"]
}
