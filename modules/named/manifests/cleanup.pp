#
# clean up unused/unnecessary files/directories
#
class named::cleanup (
) {
    file { '/etc/named.conf':
        ensure              => absent,
    }

    file { '/etc/rndc.conf':
        ensure              => absent,
    }

    file { '/etc/named.key':
        ensure              => absent,
    }

    file { '/etc/named':
        ensure              => absent,
        force               => true,
    }

    file { '/var/named/named.localhost':
        ensure              => absent,
    }

    file { '/var/named/named.loopback':
        ensure              => absent,
    }

    file { '/var/named/named.empty':
        ensure              => absent,
    }

    file { '/var/named/named.ca':
        ensure              => absent,
    }

    file { '/var/named/chroot/etc':
        ensure              => absent,
        force               => true,
    }

    file { '/var/named/chroot/run':
        ensure              => absent,
        force               => true,
    }

    file { '/var/named/chroot/usr':
        ensure              => absent,
        force               => true,
    }

    file { '/var/named/chroot/var':
        ensure              => absent,
        force               => true,
    }
}
