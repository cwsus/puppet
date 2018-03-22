class proxy::files {
    file { '/etc/httpd/conf.d/proxy.conf':
        ensure              => present,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        source              => 'puppet:///modules/proxy/etc/httpd/conf.d/proxy.conf',
        notify              => Service['httpd'],
    }

    file { '/var/www/caspersbox.com/html/proxy.pac':
        ensure              => present,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        source              => 'puppet:///modules/proxy/var/www/caspersbox.com/proxy.pac',
    }

    file { '/var/www/caspersbox.com/html/wpad.dat':
        ensure              => link,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        target              => '/var/www/caspersbox.com/html/proxy.pac',
    }

    file { '/etc/squid/squid.conf':
        ensure              => present,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        source              => 'puppet:///modules/proxy/etc/squid/squid.conf',
        notify              => Service['squid']
    }

    file { '/etc/squid/squidGuard.conf':
        ensure              => present,
        owner               => 'squid',
        group               => 'squid',
        mode                => '0644',
        source              => 'puppet:///modules/proxy/etc/squid/squidGuard.conf',
        notify              => Service['squid']
    }

    service { 'httpd':
        hasrestart          => true,
    }
}
