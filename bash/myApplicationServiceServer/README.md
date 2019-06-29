# Application Service Project

This is a colection of bash scripts, that will automate installation of services, and seting up interfaces for networks, for routers and Mail servers;

## Map of the Network
Please find below, the network map made for this project:

![Network Map](myImgFolder\myAppProjMap.jpg)


## Prerequisites

* All physical interfaces configured as instructed in the project; or as drawn on the network map above;
    * the script will match available interface to the myNetCfg.conf; and configure them accordingly;

* the conf file saved at "myNetCfg.conf" is used for altering configuration for your own vms;
    * Please enter which VM being installed on, in the myNetCfg.conf
    * enter "router" or "maill" at line 7 of the myNetCfg.conf "myVM= "
    * i.e. myVM="router"

* Fresh VMs installed with Centos7 minimum edition;
* must have the corect hostnames, to change hostname after installation;
for example:
```
hostnamectl set-hostname rtr.s17.as.learn
```

## Deployment

* clone/pull the repo:
* loged in as admin or root user;
* run the main.sh:
```
sudo bash main.sh
```

FYI: one should never sudo anything from an unknown source; did not test on a live system, use at your own risk; that said, so far it works on my VMs with a wifi dongle attached;

## Script Hierarchy

* main.sh: main invocation script
* base_configuration.sh: configure basic system
* selinux_setup.sh : configure, i.e. disable SELINUX.
* network_setup.sh: configure networking on the system by calling subscripts.
    * net_if_setup.sh: configure network interface                  #subscript
    * wifi_if_setup.sh: configure wireless interface settings       #subscript
* osfp_setup.sh: configure osfpd, and zebra
* nsd_setup.sh: configure authoritative name service
* unbound_setup.sh: configure recursive name service
* dhcpd_setup.sh: configure dhcpd service
* hostapd_setup.sh: configure hostapd service
* postfix_setup.sh: configure mail transfer agent
* dovecot_setup.sh: configure mail delivery agent
* auth_encrypt_setup.sh: configure SASL, SSL/TLS,and Generating SSL certificates


## Author

* **William SHANG** - *Email: wshang1989@gmail.com*

