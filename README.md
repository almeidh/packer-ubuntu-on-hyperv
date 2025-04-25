# packer-ubuntu-on-hyperv

### Building a custom Ubuntu VM for HyperV - Example

🖥️ Packer + HyperV

This repository provides a simple example for beginners who are getting started with Packer and Hyper-V on Windows. It walks through the process of building an Ubuntu VM image using Packer with Hyper-V as the builder.

📦 Versions Used

To ensure compatibility, use the following versions:

- Packer: v1.12.0
- Packer Hyper-V Plugin: v1.1.4
- Windows: 11 Pro

🧰 Host System Requirements

This setup is designed to be used on a Windows machine with the following prerequisites:

✅ Enable Hyper-V

Ensure Hyper-V is enabled on your host. You can enable it via PowerShell:

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

Or through the "Turn Windows features on or off" panel.

🌐 Create an External Virtual Switch

Use Hyper-V Manager to create an External Virtual Switch:

- Open Hyper-V Manager.
- Go to Virtual Switch Manager.
- Create a New External Network switch.
- Associate it with your Wi-Fi or Ethernet adapter.
- Save and apply changes.

This switch provides the VM with network access for SSH and provisioning.

⚠️ SSH Timeout Troubleshooting

If you encounter a timeout error after the following:

```
Waiting for SSH to become available...
```

This likely means the configuration is missing within the guest OS.

💡 Solution

Ensure your cloud-init or cloudconfig file installs the necessary packages.

🚀 How to Use

Clone this repository:

```
git clone https://github.com/your-org/packer-hyperv-example.git
cd packer-hyperv-example
packer init .
packer build .
```

📘 Notes

- This project is designed to be beginner-friendly.
- Feel free to customize the cloudconfig and \*.pkr.hcl files.
- Make sure you have good and stable internet connection. Build may fail using the poor connection via Wi-Fi.
- Useful for learning image building, automation, and infrastructure as code on local Windows setups.

Happy building with Packer and Hyper-V! 🧱⚙️
