class haproxy::service {
    exec { 'systemctl-enable':
        command             => '/usr/bin/systemctl enable haproxy',
        creates             => '/usr/lib/systemd/system/haproxy.service',
        returns             => '0',
        notify              => Service['haproxy'],
    }

    service { 'haproxy':
        ensure              => 'running',
        enable              => true,
        provider            => 'systemd'
    }
}
