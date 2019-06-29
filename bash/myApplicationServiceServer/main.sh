#!/bin/bash -
# by William SHANG
# completed
# main.sh: main invocation script
if [[ $myVM == "router" ]]; then
    source ./network_setup.sh
    source ./base_configuration.sh
    source ./ospf_setup.sh
    source ./dhcpd_setup.sh
    source ./nsd_setup.sh
    source ./unbound_setup.sh
    echo "restarting system..."
    systemctl reboot
elif [[ $myVM == "mail" ]]; then
    source ./network_setup.sh
    source ./base_configuration.sh
    source ./postfix_setup.sh
    source ./dovecot_setup.sh
    source ./auth_encrypt_setup.sh
    echo "restarting system..."
    systemctl reboot
else
    echo "Please enter which VM being installed on, in the myNetCfg.conf;"
    echo "enter \"router\" or \"maill\" at line 7 of the myNetCfg.conf \"myVM=\""
    echo "i.e. myVM=\"router\""
fi
