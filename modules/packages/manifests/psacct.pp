class packages::psacct (
) {
    package { 'psacct':
        ensure              => 'installed',
    }

    service { 'psacct':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}

