class packages::rkhunter (
) {
    package { 'rkhunter':
        ensure              => 'installed',
    }

    file { '/etc/rkhunter.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/rkhunter.conf',
    }

    file { '/etc/systemd/system/rkhunter.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/rkhunter-update.timer',
    }

    file { '/etc/systemd/system/rkhunter.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/rkhunter-update.service',
    }

    service { 'rkhunter.timer':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
