node /(caspersb-[m|s]dns[0-9]{2,99}\.caspersbox\.com)|(caspersb-[m|s]dns[0-9]{2,99})/ {
    include role::base
    include role::named
}

node /(caspersb-proxy[0-9]{2,99}\.caspersbox\.com)|(caspersb-proxy[0-9]{2,99})/ {
    include role::base
    include role::proxy
}

node /(caspersb-websrv[0-9]{2,99}\.caspersbox\.com)|(caspersb-websrv[0-9]{2,99})/ {
    include role::base
    include role::webserver
}

node /(caspersb-haproxy[0-9]{2,99}\.caspersbox\.com)|(caspersb-haproxy[0-9]{2,99})/ {
    include role::base
    include role::haproxy
}

node /(caspersb-dhcp[0-9]{2,99}\.caspersbox\.com)|(caspersb-dhcp[0-9]{2,99})/ {
    include role::base
    include role::dhcp
}

node default {
    include role::base
}
