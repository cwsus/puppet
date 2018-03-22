#!/usr/bin/env bash

#
# make ssh host keys if they dont exist
#

[ ! -f /etc/ssh/ssh_host_rsa_key ] && /usr/bin/env ssh-keygen -b 4096 -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
[ ! -f /etc/ssh/ssh_host_dsa_key ] && /usr/bin/env ssh-keygen -b 1024 -t dsa -N "" -f /etc/ssh/ssh_host_dsa_key
[ ! -f /etc/ssh/ssh_host_ecdsa_key ] && /usr/bin/env ssh-keygen -b 521 -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key
[ ! -f /etc/ssh/ssh_host_ed25519_key ] && /usr/bin/env ssh-keygen -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key

exit 0
