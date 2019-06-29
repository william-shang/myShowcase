#!/bin/bash -
# by William SHANG
# myAppServProj/nsd_setup.sh
# completed
# configure authoritative name service
source myNetCfg.conf
# setting up zebra.conf;
sudo mv $myNsdPath $myNsdPath.backup
sudo touch $myNsdPath
sudo echo "# $myNsdPath created using bash script" >> $myNsdPath
# nsd configuration;
sudo sed -i "\$aserver:\n        ip-address: ${eth0[IPADDR]}\n        port: 53\n        server-count: 1\n        ip4-only: yes\n        hide-version: yes\n        zonesdir: \"/etc/nsd\"\nzone:\n        name: \"$myZoneName\"\n        zonefile: \"$myZoneFile\"\nzone:\n        name: \"$myReverseName\"\n        zonefile: \"$myReverseFile\"\n" $myNsdPath
# creating zone files
sudo touch /etc/nsd/$myZoneFile
sudo echo "; zone file for $myZoneName zone" >> /etc/nsd/$myZoneFile
sudo sed -i "\$a\$TTL 10s                                ; 10 secs default TTL for zone\n$myDomainName.   IN      SOA     $myRtrHostname.$myDomainName. htp.bcit.ca. (\n                        3014022501      ; serial number of Zone Record\n                        1200s           ; refresh time\n                        180s            ; update retry time on failure\n                        1d              ; expiration time \n                        3600            ; cache time to live\n                        )\n\n;Name servers for this domain\n$myDomainName.   IN      NS      $myRtrHostname.$myDomainName.\n\n;addresses of hosts\n$myRtrHostname.$myDomainName.       IN      A       ${eth1[IPADDR]}\n$myMailHostname.$myDomainName.      IN      A       $myMailFixedAddr\n$myWifiHostname.$myDomainName.     IN      A       ${wlp0s11u1[IPADDR]}\n$myMailHostname.$myDomainName.      IN      MX  10  $myMailHostname.$myDomainName.\n$myDomainName.           IN      MX  10  $myMailHostname.$myDomainName." /etc/nsd/$myZoneFile
# creating reverse ip var
myRtrReverseIP=$(printf %s "${eth1[IPADDR]}." | tac -s.)in-addr.arpa
myMailReverseIP=$(printf %s "$myMailFixedAddr." | tac -s.)in-addr.arpa
myWin10ReverseIP=$(printf %s "$myDhcpRange_min." | tac -s.)in-addr.arpa
myWifiReverseIP=$(printf %s "${wlp0s11u1[IPADDR]}." | tac -s.)in-addr.arpa
# creating reverse zone files
sudo touch /etc/nsd/$myReverseFile
sudo echo "; zone file for ${eth0[IPADDR]} / $myZoneName reverse lookup" >> /etc/nsd/$myReverseFile
sudo sed -i "\$a\$TTL 10s                                ; 10 secs default TTL for zone\n$myReverseName.  IN      SOA     $myRtrHostname.$myDomainName. htp.bcit.ca. (\n                        3216030101      ; serial number of Zone Record\n                        1200s           ; refresh time\n                        180s            ; retry time on failure\n                        1d              ; expiration time\n                        3600            ; cache time to live\n                        )\n\n;Name servers for this domain\n$myReverseName.          IN      NS      $myRtrHostname.$myDomainName.\n\n;IP to Hostname Pointers\n$myRtrReverseIP.      IN      PTR     $myRtrHostname.$myDomainName.\n$myMailReverseIP.        IN      PTR     $myMailHostname.$myDomainName.\n$myWin10ReverseIP.      IN      PTR     $myWin10Hostname.$myDomainName.\n$myWifiReverseIP.      IN      PTR     $myWifiHostname.$myDomainName.\n" /etc/nsd/$myReverseFile
systemctl restart nsd