#!/bin/bash -
# by William SHANG
# completed
# auth_encrypt_setup.sh
# Configuring SASL in postfix
sudo sed -i "/service auth {/a  unix_listener \/var\/spool\/postfix\/private\/auth {\n    mode = 0660\n    # Assuming the default Postfix user and group\n    user = postfix\n    group = postfix\n  }\n" $myDovecot10MasterConfPath
sudo sed -i "\$a#created via script for SASL in postfix\n # Outlook Express and Windows Mail works only with LOGIN mechanism, not the standard PLAIN:\nauth_mechanisms = plain login\n" $myDovecot10MasterConfPath
sudo sed -i "\$a#created via script for SASL in postfix\nsmtpd_sasl_type = dovecot\n\n# Can be an absolute path, or relative to \$queue_directory\n# Debian/Ubuntu users: Postfix is setup by default to run chrooted, so it is best to leave it as-is below\nsmtpd_sasl_path = private/auth\n\n# On Debian Wheezy path must be relative and queue_directory defined\n#queue_directory = /var/spool/postfix\n\n# and the common settings to enable SASL:\nsmtpd_sasl_auth_enable = yes\n# With Postfix version before 2.10, use smtpd_recipient_restrictions\nsmtpd_relay_restrictions = permit_mynetworks, permit_sasl_authenticated, reject_unauth_destination\n" $myPostfixMainConfPath
sudo sed -i "/#submission inet n.*/a#created via bash script for SASL in postfix\nsubmission inet n - n - - smtpd\n  -o smtpd_tls_security_level=encrypt\n  -o smtpd_sasl_auth_enable=yes\n  -o smtpd_sasl_type=dovecot\n  -o smtpd_sasl_path=private/auth\n  -o smtpd_sasl_security_options=noanonymous\n  -o smtpd_sasl_local_domain=\$myhostname\n  -o smtpd_client_restrictions=permit_sasl_authenticated,reject\n  -o smtpd_sender_login_maps=hash:/etc/postfix/virtual\n  -o smtpd_sender_restrictions=reject_sender_login_mismatch\n  -o smtpd_recipient_restrictions=reject_non_fqdn_recipient,reject_unknown_recipient_domain,permit_sasl_authenticated,reject\n" $myPostfixMasterConfPath
# Generating SSL certificates
sudo openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=mail.s17.as.learn' -nodes
# The private key must be owned and read/writable (0600) only by root.
sudo chmod 0600 /etc/pki/tls/private/mail.s17.as.learn.key
# Configuring SSL/TLS in postfix 
sudo sed -i "\$a#created via script for SASL in postfix\nsmtpd_tls_security_level = may\nsmtpd_tls_key_file = /etc/pki/tls/private/mail.s17.as.learn .key\nsmtpd_tls_cert_file = /etc/pki/tls/certs/mail.s17.as.learn .cert\n# smtpd_tls_CAfile = /etc/pki/tls/root.crt\nsmtpd_tls_loglevel = 1\nsmtpd_tls_session_cache_timeout = 3600s\nsmtpd_tls_session_cache_database = btree:/var/lib/postfix/smtpd_tls_cache\ntls_random_source = dev:/dev/urandom\ntls_random_exchange_name = /var/lib/postfix/prng_exch\nsmtpd_tls_auth_only = yes\n" $myPostfixMainConfPath
systemctl restart postfix
# Configuring SSL/TLS in dovecot
sudo sed -i "/# Protocols we want to be serving.*/aprotocols = imap imaps pop3 pop3s\n" $myDovecotConfPath
sudo sed -i "\$a#added for SSL/TLS in dovecot\n#\n# disable_plaintext_auth = no\n#ssl_disable = no\nssl_cert_file = /etc/pki/tls/certs/mail.s17.as.learn.crt\nssl_key_file = /etc/pki/tls/private/mail.s17.as.learn.key\nssl_cipher_list = ALL:!LOW:!SSLv2\n" $myDovecotConfPath
