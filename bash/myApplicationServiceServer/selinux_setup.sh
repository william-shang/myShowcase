#!/bin/bash -
# base_configuration.sh
# configure basic system
# by William SHANG
set -o nounset          # Treat unset variables as an error
# Disabling selinux
echo "Disabling selinux"
setenforce 0
sudo sed -r -i 's/SELINUX=(enforcing|disabled)/SELINUX=permissive/' /etc/selinux/config
systemctl disable firewalld
systemctl stop firewalld
# need to reboot
# systemctl reboot
