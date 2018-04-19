; BIND version Generic-5.7-October 1998
; zone 'mgmt.caspersbox.com'   last serial 1
$ORIGIN .
$TTL 3600       ; 1 hour
mgmt.caspersbox.com IN SOA caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
        2018021300 ; serial number of this zone file
        900        ; slave refresh (15 minutes)
        3600       ; slave retry time in case of a problem (1 hour)
        604800     ; slave expiration time (1 week)
        3600       ; minimum caching time in case of failed lookups (1 hour)
        )
        IN      NS      caspersb-sdns01.caspersbox.com.
        IN      NS      caspersb-sdns02.caspersbox.com.

$ORIGIN mgmt.caspersbox.com
caspersb-vmware01    IN    A     192.168.30.5
caspersb-vmware02    IN    A     192.168.30.6

