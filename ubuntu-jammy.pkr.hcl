packer {
  # packer version: 1.12.0
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "= 1.1.4"
    }
  }
}

variable "vm_name" {
  default = "ubuntu-jammy-hyperv-test"
}

variable "iso_url" {
  default = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
}

variable "iso_checksum" {
  default = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"
}

source "hyperv-iso" "vm-ubuntu" {
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  vm_name          = var.vm_name
  cpus             = 2
  memory           = 2048
  disk_size        = 20000
  generation       = 2
  switch_name      = "EthernetExternal" # if property is not set, packer creates a new switch but it is internal by default. external switch should be used. if the property is not set, but external switch exists, packer will use this switch
  ssh_username     = "ubuntu"
  ssh_password     = "ubuntu"
  ssh_timeout      = "30m"
  ssh_port         = 22
  output_directory = "./vm-output"
  cd_files         = ["./data/meta-data", "./data/user-data"]
  cd_label         = "cidata"

  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=nocloud",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  first_boot_device = "DVD"
  boot_wait         = "10s" # Wait for the VM to boot before sending the boot command
  shutdown_command  = "echo 'packer shutting down' | sudo -S shutdown -P now"
}

build {
  sources = ["source.hyperv-iso.vm-ubuntu"]

  provisioner "shell" {
    script = "./scripts/run-install.sh"
  }
}