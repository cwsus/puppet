class dhcp::service {
    exec { 'systemctl-enable':
        command             => '/usr/bin/systemctl enable dhcpd',
        creates             => '/usr/lib/systemd/system/dhcpd.service',
        returns             => '0',
        notify              => Service['dhcpd'],
    }

    service { 'dhcpd':
        ensure              => 'running',
        enable              => true,
        provider            => 'systemd'
    }
}
