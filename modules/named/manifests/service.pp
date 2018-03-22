class named::service {
    exec { 'systemctl-enable-named':
        command             => '/usr/bin/systemctl enable named-chroot',
        creates             => '/usr/lib/systemd/system/named-chroot.service',
        returns             => '0',
        notify              => Service['named-chroot'],
    }

    service { 'named-chroot':
        ensure              => 'running',
        enable              => true,
        provider            => 'systemd'
    }
}
