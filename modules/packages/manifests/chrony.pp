class packages::chrony (
) {
    package { 'chrony':
        ensure              => 'installed',
    }

    file { '/etc/chrony.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/chrony.conf',
    }

    service { 'chronyd':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
