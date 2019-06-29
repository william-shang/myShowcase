#!/bin/bash -
# by William SHANG
# hostapd_setup.sh
# completed
# the EPEL repository is enabled. 
sudo wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-latest-7.noarch.rpm

# one or more system user accounts to receive email 
for anyUsername in "${myUsernameArray[@]}"
do
    sudo adduser ${myUsernameArray[$anyUsername]}
    sudo echo thePassword | passwd ${myUsernameArray[$anyUsername]} --stdin
    sudo usermod -aG wheel ${myUsernameArray[$anyUsername]}
done
# firewalld disabled, and off. 
systemctl disable firewalld.service
systemctl stop firewalld.service
# SELinux has been disabled 
source ./selinux_setup.sh
# NTP is installed and working 
sudo timedatectl set-ntp yes
# installing tools for future testing;
sudo yum -y install telnet
# Configure Postfix to listen to all interfaces
sed -i '/^#/!s/\(inet_interfaces =\)\(.*\)/\1 all/' $myPostfixMainConfPath
# Update The email destination
# update the line that starts with mydestination(164-167)
sed -i '/^#/!s/\(mydestination =\)\(.*\)/\1 $myhostname, localhost.$mydomain, localhost, $mydomain/' $myPostfixMainConfPath
# Configure and note the path of the mailbox
sed -i "/#home_mailbox = Maildir.*/a home_mailbox = Maildir\n" $myPostfixMainConfPath
# creates the mailboxs
sudo mkdir /home/wshang/Maildir/
sudo mkdir /home/wshang1989/Maildir/
sudo chown wshang:wshang /home/wshang/Maildir
sudo chown wshang1989:wshang1989 /home/wshang1989/Maildir
sudo chmod -R 700 /home/wshang/Maildir
sudo chmod -R 700 /home/wshang1989/Maildir
# Restart the postfix daemon
systemctl restart postfix.service
