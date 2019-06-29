#!/bin/bash -
# by William SHANG
# base_configuration.sh
# configure basic system
# Turning off and disabling Network Manager,Firewall Daemon
systemctl stop NetworkManager.service
systemctl disable NetworkManager.service
systemctl stop firewalld.service
systemctl disable firewalld.service
# Enabling and starting the Network Service
systemctl enable network.service
systemctl start network.service
# Enable sshd
systemctl enable sshd.service
systemctl start sshd.service
# Enabling IP forwarding;
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
# setting up each interfaces using subscripts;
source ./net_if_setup.sh
source ./wifi_if_setup.sh
systemctl restart network.service
