class packages::sysstat (
) {
    package { 'sysstat':
        ensure              => 'installed',
    }

    service { 'sysstat':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
