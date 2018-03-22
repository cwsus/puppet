; BIND version Generic-5.7-October 1998
; zone 'caspersbox.com'   last serial 1
$ORIGIN .
$TTL 3600       ; 1 hour
caspersbox.com IN SOA caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
        2017121500 ; serial number of this zone file
        900        ; slave refresh (15 minutes)
        3600       ; slave retry time in case of a problem (1 hour)
        604800     ; slave expiration time (1 week)
        3600       ; minimum caching time in case of failed lookups (1 hour)
        )
        IN      NS      caspersb-sdns01.caspersbox.com.
        IN      NS      caspersb-sdns02.caspersbox.com.
        IN      NS      caspersb-sdns03.caspersbox.com.
        IN      NS      caspersb-sdns04.caspersbox.com.

$ORIGIN caspersbox.com
caspersb-haproxy01                  IN      A       192.168.10.100
caspersb-websrv01                   IN      A       192.168.10.101
caspersb-websrv02                   IN      A       192.168.10.102
caspersb-cloud01                    IN      A       192.168.10.105
caspersb-proxy01                    IN      A       192.168.10.107
caspersb-proxy02                    IN      A       192.168.10.108
caspersb-mdns01                     IN      A       192.168.10.109
caspersb-sdns01                     IN      A       192.168.10.110
caspersb-sdns02                     IN      A       192.168.10.111
caspersb-sdns03                     IN      A       192.168.10.112
caspersb-sdns04                     IN      A       192.168.10.113
caspersb-dhcp01                     IN      A       192.168.10.114
caspersb-dhcp02                     IN      A       192.168.10.115
caspersb-sql01                      IN      A       192.168.10.116
caspersb-redis01                    IN      A       192.168.10.117
caspersb-redis02                    IN      A       192.168.10.118
caspersb-puppet01                   IN      A       192.168.10.120
caspersb-sysadm                     IN      A       192.168.10.200
caspersb-build01                    IN      A       192.168.10.202
caspersb-proxmox                    IN      A       192.168.10.250

; SYSTEM NAMES
proxy                               IN      A       192.168.10.10
wpad                                IN      A       192.168.10.11
owncloud                            IN      A       192.168.10.12

; CNAMES
proxmox                             IN      CNAME   caspersb-proxmox.caspersbox.com.
pfsense                             IN      CNAME   caspersb-pfsense.network.caspersbox.com.
proxysvc                            IN      CNAME   wpad.caspersbox.com.

