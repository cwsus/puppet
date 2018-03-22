class packages::aide (
) {
    package { 'aide':
        ensure              => 'installed',
    }

    file { '/etc/aide.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/aide.conf',
    }

    file { '/etc/systemd/system/aide.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/aide.timer',
    }

    file { '/etc/systemd/system/aide.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/aide.service',
    }

    service { 'aide.timer':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}

