#!/bin/bash -
# myAppServProj/dhcpd_setup.sh
# completed
# by William SHANG
source myAppServProj/myNetCfg.conf
# install /start /enable dhcp
yum install dhcp
systemctl start dhcp
systemctl enable dhcp
# setting up zebra.conf;
sudo mv $myDhcpPath $myDhcpPath.backup
sudo touch $myDhcpPath
sudo echo "# $myDhcpPath created using bash script" >> $myDhcpPath
# dhcp configuration;
sudo sed -i "\$aoption  domain-name "$myDomainName";\noption  domain-name-servers ${eth0[IPADDR]};\nsubnet $myDhcpSubnet netmask $myDhcpSubnetMask {\n        interface $myDhcpInterface;\n        option routers ${eth1[IPADDR]};\n        option subnet-mask ${eth1[NETMASK]};\n        range $myMailFixedAddr $myMailFixedAddr;\n        host mail{\n                fixed-address $myMailFixedAddr;\n        }\n        range $myDhcpRange_min $myDhcpRange_max;\n}" $myDhcpPath
# wifi dhcp configuration;
sudo sed -i "\$asubnet $myDhcpWifiSubnet netmask $myDhcpWifiSubnetMask {\n        interface $myDhcpWifiInterface;\n        option routers ${wlp0s11u1[IPADDR]};\n        option subnet-mask $myDhcpWifiSubnetMask;\n        range $myDhcpWifiRange_min $myDhcpWifiRange_max;\n}" $myDhcpPath
systemctl restart dhcpd
systemctl restart network