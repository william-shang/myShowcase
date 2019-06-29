#!/bin/bash -
# by William SHANG
# myAppServProj/hostapd_setup.sh
# completed
# Install hostapd 
sudo yum -y install hostapd
# Edit the required configuration files
sudo mv $myHostapdPath $myHostapdPath.backup
sudo touch $myHostapdPath
sudo echo "# $myHostapdPath created using bash script" >> $myHostapdPath
sudo sed -i "\$ainterface=$myDhcpWifiInterface\ndriver=nl80211\nssid=NASP21_S17\nhw_mode=g\nchannel=1\nmacaddr_acl=0\nignore_broadcast_ssid=0\nauth_algs=1\n" $myHostapdPath
# Restart network.service 
systemctl restart network.service
# Start and Enable hostapd 
systemctl Start hostapd.service
systemctl Enable hostapd.service
