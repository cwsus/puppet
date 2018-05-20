; BIND version Generic-5.7-October 1998
; zone 'caspersbox.com'   last serial 1
$ORIGIN .
$TTL 3600       ; 1 hour
caspersbox.com IN SOA caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
        2018050500 ; serial number of this zone file
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
caspersb-mdns01             IN      A       192.168.20.10
caspersb-sdns01             IN      A       192.168.20.11
caspersb-sdns02             IN      A       192.168.20.12
caspersb-dhcp01             IN      A       192.168.20.13
caspersb-proxy01            IN      A       192.168.20.14
caspersb-sdns03             IN      A       192.168.20.21
caspersb-sdns04             IN      A       192.168.20.22
caspersb-dhcp02             IN      A       192.168.20.23
caspersb-proxy02            IN      A       192.168.20.24
