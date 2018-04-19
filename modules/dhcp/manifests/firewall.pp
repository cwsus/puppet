class dhcp::firewall (
) {
    file { '/usr/local/bin':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/usr/local/bin/iptables.ksh':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
        source              => 'puppet:///modules/dhcp/usr/local/bin/iptables.ksh',
        require             => Package['dhcp'],
    }
}
