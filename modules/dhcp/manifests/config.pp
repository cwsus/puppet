class dhcp::config {
    file { '/etc/dhcp/dhcpd.conf':
        ensure              => file,
        owner               => 'dhcpd',
        group               => 'dhcpd',
        mode                => '0644',
        content             => template('dhcp/dhcpd.conf.erb'),
        require             => Package['dhcp'],
    }
}
