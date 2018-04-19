node /(caspersb-[m|s]dns[0-9]{2,99}\.caspersbox\.com)|(caspersb-[m|s]dns[0-9]{2,99})/ {
    include role::base
    include role::named
}

node default {
    include role::base
}

