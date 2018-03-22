#!/usr/bin/env ksh
## SERVER FIREWALL

set NETWORK_ADDR="192.168.10.0/24";
set -A PROXYSERVERS "192.168.10.107" "192.168.10.108";
set -A DNSSERVERS "192.168.10.110" "192.168.10.111" "192.168.10.112" "192.168.10.113";

## flush
/usr/bin/env iptables -F
/usr/bin/env iptables -X

## default
/usr/bin/env iptables -P INPUT   DROP
/usr/bin/env iptables -P FORWARD DROP
/usr/bin/env iptables -P OUTPUT  DROP
/usr/bin/env iptables -P DHCP-SERVICES DROP
/usr/bin/env iptables -N SYN-FLOOD
/usr/bin/env iptables -F SYN-FLOOD

## default for lo interface
/usr/bin/env iptables -A INPUT  -i lo -s 127.0.0.0/8 -d 127.0.0.0/8 -j ACCEPT
/usr/bin/env iptables -A OUTPUT -o lo -s 127.0.0.0/8 -d 127.0.0.0/8 -j ACCEPT

## allow connections that have already been made to remain made
/usr/bin/env iptables -A INPUT   -s 0/0 -d 0/0 -m state --state ESTABLISHED,RELATED -j ACCEPT
/usr/bin/env iptables -A OUTPUT  -s 0/0 -d 0/0 -m state --state ESTABLISHED,RELATED -j ACCEPT
/usr/bin/env iptables -A FORWARD -s 0/0 -d 0/0 -m state --state ESTABLISHED,RELATED -j ACCEPT

## allow icmp echo - LOCAL ONLY
/usr/bin/env iptables -A INPUT  -s ${NETWORK_ADDR} -d ${NETWORK_ADDR} -m state --state NEW,ESTABLISHED,RELATED -p icmp --icmp-type 8 -j ACCEPT
/usr/bin/env iptables -A INPUT  -s ${NETWORK_ADDR} -d ${NETWORK_ADDR} -m state --state ESTABLISHED,RELATED     -p icmp --icmp-type 0 -j ACCEPT
/usr/bin/env iptables -A OUTPUT -s ${NETWORK_ADDR} -d 0/0             -m state --state NEW,ESTABLISHED,RELATED -p icmp --icmp-type 8 -j ACCEPT
/usr/bin/env iptables -A OUTPUT -s ${NETWORK_ADDR} -d 0/0             -m state --state ESTABLISHED,RELATED     -p icmp --icmp-type 0 -j ACCEPT

for INTERFACE in $(/usr/bin/env ip addr show | /usr/bin/env grep inet | /usr/bin/env awk '{print $2}' | /usr/bin/env cut -d "/" -f 1 | /usr/bin/env grep -v "127.0.0.1")
do
    ## web through the proxy please
    for PROXYSVR in ${PROXYSERVERS[*]}
    do
        /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${PROXYSVR} -m state --state NEW,ESTABLISHED,RELATED -m tcp -p tcp --sport 1024:65535 --dport 3128  -j ACCEPT
        /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${PROXYSVR} -m state --state NEW,ESTABLISHED,RELATED -m tcp -p tcp --sport 1024:65535 --dport 8080  -j ACCEPT

        /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${PROXYSVR} -m state --state NEW,ESTABLISHED,RELATED -m tcp -p tcp --sport 1024:65535 --dport 3128  -j ACCEPT
        /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${PROXYSVR} -m state --state NEW,ESTABLISHED,RELATED -m tcp -p tcp --sport 1024:65535 --dport 8080  -j ACCEPT

        [ ! -z "${PROXYSVR}" ] && unset -v PROXYSVR;
    done

    ## DNS services
    for DNSSVR in ${DNSSERVERS[*]}
    do
        [ "${DNSSVR}" == "${INTERFACE}" ] && continue; ## don't write a rule for itself

        /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${DNSSVR} -m state --state NEW,ESTABLISHED,RELATED -m udp -p udp --sport 1024:65535 --dport 53  -j ACCEPT

        [ ! -z "${DNSSVR}" ] && unset -v DNSSVR;
    done

    ## dhcp
    /usr/bin/env iptables -A DHCP-SERVICES -i eth0 -s ${NETWORK_ADDR} -d ${INTERFACE} -m state --state NEW -m udp -p udp --sport 67:68 --dport 67:68 -j ACCEPT
    /usr/bin/env iptables -A DHCP-SERVICES -o eth0 -s ${INTERFACE} -d ${NETWORK_ADDR} -m state --state ESTABLISHED,RELATED -m udp -p udp --sport 67:68 --dport 67:68 -j ACCEPT

    ## ssh yeah
    /usr/bin/env iptables -A INPUT -i eth+ -s 0/0 -d ${INTERFACE} -m state --state NEW -m recent -m tcp -p tcp --set
    /usr/bin/env iptables -A INPUT -i eth+ -s 0/0 -d ${INTERFACE} -m state --state NEW -m recent -m tcp -p tcp --update --seconds 60 --hitcount 5 -j DROP
    /usr/bin/env iptables -A INPUT -i eth+ -s ${NETWORK_ADDR} -d ${INTERFACE} -m state --state NEW -m tcp -p tcp --sport 1024:65535 --dport 22 -j ACCEPT
    /usr/bin/env iptables -A OUTPUT -o eth+ -s ${INTERFACE} -d ${NETWORK_ADDR} -m state --state ESTABLISHED,RELATED -m tcp -p tcp --sport 22 --dport 1024:65535 -j ACCEPT

    [ ! -z "${INTERFACE}" ] && unset -v INTERFACE;
done

[ ! -z "${NETWORK_ADDR}" ] && unset -v NETWORK_ADDR;
[ ! -z "${PROXYSERVERS}" ] && unset -v PROXYSERVERS;
[ ! -z "${DHCPSERVERS}" ] && unset -v DHCPSERVERS;
[ ! -z "${DNSSERVERS}" ] && unset -v DNSSERVERS;
