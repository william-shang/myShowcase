#!/bin/bash -
# base_configuration.sh
# configure basic system
# by William SHANG
set -o nounset          # Treat unset variables as an error
# incase the fresh VM has no DNS setup;
# use
sudo echo "nameserver 142.232.221.254" >> /etc/resolv.conf
# Installing base packages
sudo yum -y update
sudo echo "group_package_types=mandatory,default,optional" >> /etc/yum.conf
sudo yum -y group install base
# Installing the Extra Packages for Enterprise Linux Repository
sudo yum -y install epel-release
sudo yum -y update
# Installing project specific tools
sudo yum -y install curl vim wget tmux nmap-ncat tcpdump nmap
# Setting Up VirtualBox Guest Additions;
sudo yum -y install kernel-devel kernel-headers dkms gcc gcc-c+
source selinux_setup.sh
