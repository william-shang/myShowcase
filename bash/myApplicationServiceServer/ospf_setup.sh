#!/bin/bash -
# by William SHANG
# myAppServProj/ospf_setup.sh
# completed
source ./myNetCfg.conf
# installing quagga and starting ospfd/zebra
sudo yum install quagga
sudo yum update
systemctl enable zebra
systemctl start zebra
systemctl enable ospfd
systemctl start ospfd
# setting up zebra.conf;
sudo mv $myZebraPath $myZebraPath.backup
sudo touch $myZebraPath
sudo echo "# $myZebraPath created using bash script" >> $myZebraPath
sudo sed -i "\$ahostname $myRtrHostname.$myDomain\npassword $zebraPass\nenable password $zebraEnablePass\n\!\ninterface lo\n\!\nline vty\n\!\nlog file /var/log/quagga/quagga.log\n\!" $myZebraPath
# creating active interface array
declare -a myIfcfgArray=()
for myIfcfg in $(ip a | cut -d ' ' -f2| tr ':' '\n' | awk NF)
do
    if [ "$myIfcfg" != "lo" ]; then
        myIfcfgArray+=("$myIfcfg")
    fi
done
# looping to update ospfd files for active interface
for anyInterface in "${myIfcfgArray[@]}"
do
    if [[ "$(declare -p $anyInterface 2>/dev/null)" == "declare -A"* ]]; then
        sudo sed -i "/enable password.*/a interface $anyInterface\n\ description $anyInterface\n\ ip address ${anyInterface[IPADDR]}/${anyInterface[PREFIX]}\n\ ipv6 nd suppress-ra\n\ ip forwarding\n\!" $myZebraPath
    fi
done
systemctl restart zebra
############################################
# setting up ospfd.conf;
sudo mv $myOspfdPath $myOspfdPath.backup
sudo touch $myOspfdPath
sudo echo "# $myOspfdPath created using bash script" >> $myOspfdPath
sudo sed -i "\$ahostname $myRtrHostname.$myDomain\npassword $ospfPass\nenable password $ospfEnablePass\n\!\nrouter ospf\n\ ospf router-id ${eth0[IPADDR]}\n\!\nline vty\n\!\nlog file /var/log/quagga/ospfd.log\nlog stdout\n\!" $myOspfdPath
# creating active interface array
declare -a myIfcfgArray=()
for myIfcfg in $(ip a | cut -d ' ' -f2| tr ':' '\n' | awk NF)
do
    if [ "$myIfcfg" != "lo" ]; then
        myIfcfgArray+=("$myIfcfg")
    fi
done
# looping to update ospfd files for active interface
for anyInterface in "${myIfcfgArray[@]}"
do
    if [[ "$(declare -p $anyInterface 2>/dev/null)" == "declare -A"* ]]; then
        sudo sed -i "/enable password.*/a interface $anyInterface\n\!" $myOspfdPath
        sudo sed -i "/ospf router-id ${eth0[IPADDR]}/a \ network ${anyInterface[NETWORK]}/${anyInterface[PREFIX]} area 0" "$myOspfdPath"
    fi
done
systemctl restart ospfd
systemctl restart network
