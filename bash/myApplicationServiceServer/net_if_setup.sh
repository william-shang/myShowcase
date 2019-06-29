#!/bin/bash -
# completed
# myAppServProj/net_if_setup.sh
# by William SHANG
source ./myNetCfg.conf
# looping to save all active interface into a arry
if [[ $myVM == "router" ]]; then
    declare -a myIfcfgArray=()
    for myIfcfg in $(ip a | cut -d ' ' -f2| tr ':' '\n' | awk NF)
    do
        if [ "$myIfcfg" != "lo" ]; then
            myIfcfgArray+=("$myIfcfg")
        fi
    done
    # looping to create ifcfg files for active interface;
    for anyInterface in "${myIfcfgArray[@]}"
    do
        if [[ "$(declare -p $anyInterface 2>/dev/null)" == "declare -A"* ]]; then
            sudo echo "creating interface: $anyInterface"
            myIfcfgFilePath=/etc/sysconfig/network-scripts/ifcfg-$anyInterface
            # temp vars for the ifcfg files;
            tempDEVICE="${anyInterface}[DEVICE]"
            tempBOOTPROTO="${anyInterface}[BOOTPROTO]"
            tempVLAN="${anyInterface}[VLAN]"
            tempIPADDR="${anyInterface}[IPADDR]"
            tempPREFIX="${anyInterface}[PREFIX]"
            tempGATEWAY="${anyInterface}[GATEWAY]"
            tempDNS="${anyInterface}[DNS1]"
            # make a backup if the file exits;
            if [ -e $myIfcfgFilePath ]
            then
                sudo mv $myIfcfgFilePath $myIfcfgFilePath.backup 
            fi      
            # creating the ifcfg files;
            sudo touch $myIfcfgFilePath
            sudo echo "# ifcfg-$anyInterface created using bash script" >> $myIfcfgFilePath
            # filling in the ifcfg files;
            sudo sed -i "\$aONBOOT=yes\nTYPE=Ethernet\nNM_CONTROLLED=no\nBOOTPROTO=${!tempBOOTPROTO}\nDEVICE=${!tempDEVICE}\nIPADDR=${!tempIPADDR}\nPREFIX=${!tempPREFIX}" $myIfcfgFilePath
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
        fi
    done
elif [[ $myVM == "mail" ]]; then
    myIfcfgFilePath=/etc/sysconfig/network-scripts/ifcfg-${myMailEth0[DEVICE]}
    # temp vars for the ifcfg files;
    tempDEVICE="${myMailEth0}[DEVICE]"
    tempBOOTPROTO="${myMailEth0}[BOOTPROTO]"
    tempVLAN="${myMailEth0}[VLAN]"
    tempIPADDR="${myMailEth0}[IPADDR]"
    tempPREFIX="${myMailEth0}[PREFIX]"
    tempGATEWAY="${myMailEth0}[GATEWAY]"
    tempDNS="${myMailEth0}[DNS1]"
    # make a backup if the file exits;
    if [ -e $myIfcfgFilePath ]
    then
        sudo mv $myIfcfgFilePath $myIfcfgFilePath.backup 
    fi      
    # creating the ifcfg files;
    sudo touch $myIfcfgFilePath
    sudo echo "# ifcfg-$anyInterface created using bash script" >> $myIfcfgFilePath
    # filling in the ifcfg files;
    sudo sed -i "\$aONBOOT=yes\nTYPE=Ethernet\nNM_CONTROLLED=no\nBOOTPROTO=${!tempBOOTPROTO}\nDEVICE=${!tempDEVICE}\nIPADDR=${!tempIPADDR}\nPREFIX=${!tempPREFIX}" $myIfcfgFilePath
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
    sudo ifup ifcfg-${myMailEth0[DEVICE]}

fi

