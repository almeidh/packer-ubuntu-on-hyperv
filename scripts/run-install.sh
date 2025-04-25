#!/bin/bash
set -e
set -o pipefail

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

sudo apt-get update
sudo apt-get remove -y systemd-timesyncd
sudo apt-get upgrade -y
sudo apt update && sudo apt upgrade -y
sudo apt-get install -y open-vm-tools jq zip unzip tree net-tools git
echo "Ubuntu VM for HyperV!" | sudo tee /ubuntu-jammy.txt > /dev/null