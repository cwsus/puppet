class dhcp::config {
    file { '/etc/hosts.allow':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/dhcp/etc/hosts.allow',
    }

    file { '/etc/dhcp/dhcpd.conf':
        ensure              => file,
        owner               => 'dhcpd',
        group               => 'dhcpd',
        mode                => '0644',
        content             => template('dhcp/dhcpd.conf.erb'),
        require             => Package['dhcp'],
    }
}
