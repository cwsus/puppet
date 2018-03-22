; BIND version Generic-5.7-October 1998
; zone 'network.caspersbox.com'   last serial 1
$ORIGIN .
$TTL 3600       ; 1 hour
network.caspersbox.com IN SOA caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
        2017121800 ; serial number of this zone file
        900        ; slave refresh (15 minutes)
        3600       ; slave retry time in case of a problem (1 hour)
        604800     ; slave expiration time (1 week)
        3600       ; minimum caching time in case of failed lookups (1 hour)
        )
        IN      NS      caspersb-sdns01.caspersbox.com.
        IN      NS      caspersb-sdns02.caspersbox.com.
        IN      NS      caspersb-sdns03.caspersbox.com.
        IN      NS      caspersb-sdns04.caspersbox.com.

$ORIGIN network.caspersbox.com
caspersb-pfsense-wan    IN      A       192.168.5.1
caspersb-pfsense-vpn    IN      A       192.168.8.1
caspersb-cs2811-wan     IN      A       192.168.5.2
caspersb-cs2811-lan     IN      A       192.168.10.1
caspersb-cs3750         IN      A       192.168.10.2
caspersb-en2500         IN      A       192.168.10.5


