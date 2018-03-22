class proxy {
    include proxy::packages
    include proxy::groups
    include proxy::accounts
    include proxy::directories
    include proxy::files

    exec { 'build-proxy-cache':
        command             => 'squid -z',
        user                => 'squid',
        notify              => Service['squid'],
    }

    service { 'squid':
        hasrestart          => true,
    }
}
