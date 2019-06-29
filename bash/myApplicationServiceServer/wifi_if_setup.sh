#!/bin/bash -
# completed
# wifi_if_setup.sh
# by William SHANG
source ./myNetCfg.conf
# looping to save all active interface into a arry;
declare -a myWifiIfcfgArray=()
for myWifiIfcfg in $(ip a | cut -d ' ' -f2| tr ':' '\n' | awk NF)
do
    if [[ $myWifiIfcfg == *"wlp0s"* ]]; then
        sudo echo "interface $myWifiIfcfg is stored in array"
        myWifiIfcfgArray+=("$myWifiIfcfg")
    fi
done
# looping to create ifcfg files for active interface;
for anyInterface in "${myWifiIfcfgArray[@]}"
do
    if [[ "$(declare -p $anyInterface 2>/dev/null)" == "declare -A"* ]]; then
        myIfcfgFilePath=/etc/sysconfig/network-scripts/ifcfg-$anyInterface
        # temp vars for the ifcfg files;
        tempDEVICE="${anyInterface}[DEVICE]"
        tempBOOTPROTO="${anyInterface}[BOOTPROTO]"
        tempVLAN="${anyInterface}[VLAN]"
        tempIPADDR="${anyInterface}[IPADDR]"
        tempPREFIX="${anyInterface}[PREFIX]"
        tempGATEWAY="${anyInterface}[GATEWAY]"
        tempDNS="${anyInterface}[DNS1]"
        tempCHANNEL="${anyInterface}[CHANNEL]"
        tempESSID="${anyInterface}[ESSID]"
        # make a backup if the file exits;
        if [ -e $myIfcfgFilePath ]
        then
	        sudo mv $myIfcfgFilePath $myIfcfgFilePath.backup 
        fi
        # creating the ifcfg files;
        sudo touch $myIfcfgFilePath
        sudo echo "# ifcfg-$anyInterface created using bash script" >> $myIfcfgFilePath
        # filling in the ifcfg files;
        sudo sed -i "\$aONBOOT=yes\nNM_CONTROLLED=no\nMODE=Master\nRATE=Auto\nTYPE=Wireless\nDEVICE=${!tempDEVICE}\nBOOTPROTO=${!tempBOOTPROTO}\nIPADDR=${!tempIPADDR}\nPREFIX=${!tempPREFIX}\nESSID=${!tempCHANNEL}\nCHANNEL=${!tempESSID}" $myIfcfgFilePath
        # add GATEWAY if it's in the conf file;
        if [ "${!tempGATEWAY}" != "" && "${!tempGATEWAY}" != " " ]; then
            sudo sed -i "\$aGATEWAY=${!tempGATEWAY}" $myIfcfgFilePath
        fi
        # add DNS if it's in the conf file;
        if [ "${!tempDNS}" != "" && "${!tempDNS}" != " " ]; then
            sudo sed -i "\$aDNS1=${!tempDNS}" $myIfcfgFilePath
        fi
        # add VLAN if it's in the conf file;
        if [ "${!tempVLAN}" != "" && "${!tempVLAN}" != " " ]; then
            sudo sed -i "\$aVLAN=${!tempVLAN}" $myIfcfgFilePath
        fi
        sudo ifup ifcfg-$anyInterface
        source ./hostapd_setup.sh
    fi    
done
