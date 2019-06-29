#!/bin/bash -
# by William SHANG
# dovecot_setup.sh
# completed
# Install/start/enable dovecot package
sudo yum install dovecot
systemctl enable dovecot
systemctl start dovecot
# Configure Dovecot protocols by modifying by editing the main Dovecot configuration file (File phath : /etc/dovecot/dovecot.conf)
if ! grep -q "protocols = \"imap lmtp\"" "$myPostfixMainConfPath"; then
    sudo sed -i "/# Protocols we want to be serving.*/a protocols = \"imap lmtp\"\n" $myPostfixMainConfPath
fi
if ! grep -q "login_trusted_networks = 10.0.0.0/8" "$myPostfixMainConfPath"; then
    sudo sed -i "/# these networks. Typically you\'d specify your IMAP Proxy servers here.*/a login_trusted_networks = 10.0.0.0/8\n" $myPostfixMainConfPath
fi
# specify the mail location by uncommenting
sudo sed -i '/mail_location = maildir:~/Maildir/s/^#//g' $myDovecot10MailConfPath
# Allow plaintext authentication
sudo sed -i '/^#/!s/\(disable_plaintext_auth =\)\(.*\)/\1 no/' $myDovecot10MailConfPath
sudo sed -i '/^#/!s/\(auth_mechanisms =\)\(.*\)/\1 plain/' $myDovecot10MailConfPath
systemctl restart dovecot.service
