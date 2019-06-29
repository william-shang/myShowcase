#!/bin/bash -
# by William SHANG
# unbound_setup.sh
# completed
# internet required
# getting root hint;
sudo wget -S -N https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints
# configure for unbound
source myNetCfg.conf
# setting up unbound.conf;
sudo mv $myUnboundPath $myUnboundPath.backup
sudo touch $myUnboundPath
sudo echo "# $myUnboundPath created using bash script" >> $myUnboundPath
# unbound configuration;
sudo sed -i "\$aserver:\n        interface: $myLoopback\n        interface: ${eth1[IPADDR]}\n        interface: ${wlp0s11u1[IPADDR]}\n        verbosity: 1\n        port: 53\n        do-ip4: yes\n        do-ip6: no\n        do-udp: yes\n        do-tcp: yes\n        access-control: ${eth1[NETWORK]}/${eth1[PREFIX]} allow\n        access-control: 127.0.0.0/8 allow\n        access-control: 0.0.0.0/0 refuse\n        access-control: ::0/0 refuse\n        chroot: \"\"\n        username: \"unbound\"\n        directory: \"/etc/unbound\"\n        root-hints: \"/etc/unbound/root.hints\"\n        pidfile: \"/var/run/unbound/unbound.pid\"\n        private-domain: \"as.learn\"\n        local-zone: \"$myReverseName.\" nodefault\n        prefetch: yes\n        module-config: \"iterator\"\n        include: /etc/unbound/local.d/*.conf\nremote-control:\n        control-enable: yes\n        server-key-file: \"/etc/unbound/unbound_server.key\"\n        server-cert-file: \"/etc/unbound/unbound_server.pem\"\n        control-key-file: \"/etc/unbound/unbound_control.key\"\n        control-cert-file: \"/etc/unbound/unbound_control.pem\"\ninclude: /etc/unbound/conf.d/*.conf\nstub-zone:\n        name: \"$myZoneName\"\n        stub-addr: ${eth0[IPADDR]}\nstub-zone:\n        name: \"255.16.10.in-addr.arpa\"\n        stub-addr: ${eth0[IPADDR]}\nforward-zone:\n        name: \".\"\n        forward-addr: $myUpstreamDns\nforward-zone:\n        name: \"bcit.ca\"\n        forward-addr: $myUpstreamDns\nforward-zone:\n        name: \"learn\"\n        forward-addr: $myUpstreamDns\nforward-zone:\n        name: \"htp.bcit.ca\"\n        forward-addr: $myUpstreamDns\n" $myUnboundPath
sudo mv $myResolvPath $myResolvPath.backup
sudo touch $myResolvPath
sudo echo "# $myResolvPath created using bash script" >> $myResolvPath
sudo sed -i "\$asearch $myDomainName\nnameserver $myLoopback" $myResolvPath
systemctl restart unbound
