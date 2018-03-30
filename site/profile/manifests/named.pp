#
# named profile. cleans/configured dns services
#
class profile::named (
) {
    file { '/etc/named':
        path                => '/etc/named',
        ensure              => absent,
        purge               => true,
        recurse             => true,
        force               => true,
    }

    file { '/var/named/chroot/slaves':
        path                => '/var/named/chroot/slaves',
        ensure              => absent,
        purge               => true,
        recurse             => true,
        force               => true,
    }

    file { '/var/named/chroot/data':
        path                => '/var/named/chroot/data',
        ensure              => absent,
        purge               => true,
        recurse             => true,
        force               => true,
    }

    file { '/var/named/chroot/dynamic':
        path                => '/var/named/chroot/dynamic',
        ensure              => absent,
        purge               => true,
        recurse             => true,
        force               => true,
    }

    include named::packages
    include named::accounting
    include named::config
    include named::zones

    service { 'named-chroot':
        ensure              => 'running',
        enable              => true,
        provider            => 'systemd'
    }
}
