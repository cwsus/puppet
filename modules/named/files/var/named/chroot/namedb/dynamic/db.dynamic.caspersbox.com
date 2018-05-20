; BIND version Generic-5.7-October 1998
; zone 'dynamic.caspersbox.com'   last serial 1
$ORIGIN .
$TTL 3600           ; 1 hour
dynamic.caspersbox.com  IN SOA  caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
            2018050500 ; serial
            900        ; refresh (15 minutes)
            3600       ; retry (1 hour)
            604800     ; expire (1 week)
            3600       ; minimum (1 hour)
            )
            IN      NS      caspersb-sdns01.caspersbox.com.
            IN      NS      caspersb-sdns02.caspersbox.com.
            IN      NS      caspersb-sdns03.caspersbox.com.
            IN      NS      caspersb-sdns04.caspersbox.com.

$ORIGIN dynamic.caspersbox.com.
