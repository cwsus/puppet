class packages::clamav (
) {
    package { 'clamav':
        ensure              => 'installed',
    }

    package { 'clamav-data':
        ensure              => 'installed',
    }

    package { 'clamav-filesystem':
        ensure              => 'installed',
    }

    package { 'clamav-lib':
        ensure              => 'installed',
    }

    package { 'clamav-scanner':
        ensure              => 'installed',
    }

    package { 'clamav-scanner-systemd':
        ensure              => 'installed',
    }

    package { 'clamav-unofficial-sigs':
        ensure              => 'installed',
    }

    package { 'clamav-update':
        ensure              => 'installed',
    }

    file { '/etc/systemd/system/freshclam.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/freshclam.timer',
    }

    file { '/etc/systemd/system/freshclam.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/freshclam.service',
    }

    file { '/etc/freshclam.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/freshclam.conf',
    }

    file { '/etc/clamd.d/scan.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/clamd.d/scan.conf',
    }

    service { 'freshclam.timer':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
