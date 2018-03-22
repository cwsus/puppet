$ORIGIN .
$TTL 3600	; 1 hour
dynamic.caspersbox.com	IN SOA	caspersb-mdns01.caspersbox.com. dnsadm.caspersbox.com. (
				2017112751 ; serial
				900        ; refresh (15 minutes)
				3600       ; retry (1 hour)
				604800     ; expire (1 week)
				3600       ; minimum (1 hour)
				)
			NS	caspersb-sdns01.caspersbox.com.
			NS	caspersb-sdns02.caspersbox.com.
			NS	caspersb-sdns03.caspersbox.com.
			NS	caspersb-sdns04.caspersbox.com.
$ORIGIN dynamic.caspersbox.com.
caspersb-hp6300		A	192.168.10.87
$TTL 1800	; 30 minutes
			TXT	"31bfc074f425a6e389d7dd60c0082008fa"
$TTL 3600	; 1 hour
caspersb-hp9480		A	192.168.10.181
			TXT	"317355ecfa10a7de13dda41a2ad4444a5e"
caspersb-ldap02		A	192.168.10.185
$TTL 1800	; 30 minutes
			TXT	"0035c50d7d21a0bc8bb114529842e8d4c2"
$TTL 3600	; 1 hour
caspersb-ps4		A	192.168.10.80
			TXT	"318d5e9e3609c408cf0df52a137087eaf0"
caspersb-s230u		A	192.168.10.96
$TTL 1800	; 30 minutes
			TXT	"31509af1f08585837938ff3aa91d816921"
$TTL 3600	; 1 hour
Chromecast		A	192.168.10.34
			TXT	"00aac2c0f357723a6121e928a6e3932f66"
DESKTOP-6PK8R2K		A	192.168.10.96
			TXT	"31fe3b036be4b1872bc02740557e92a0f8"
iPhone			A	192.168.10.41
$TTL 1800	; 30 minutes
			TXT	"3198d034b07f08ae5b8f831ca0cc4496d6"
$TTL 3600	; 1 hour
MTB-iPhone		A	192.168.10.70
			TXT	"311f961aa7357cb899b637a5548de2e639"
Wolfy-iphone		A	192.168.10.95
			TXT	"3109de628c587cf85d53c73832985794e2"
