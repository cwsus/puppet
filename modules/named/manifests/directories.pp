class named::directories {
    file { '/var/named':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/tmp':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/log':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/named':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/run':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/run':
        ensure              => link,
        target              => '/var/named/chroot/var/run',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr/lib64':
        ensure              => link,
        target              => '/var/named/chroot/run',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr/lib64/bind':
        ensure              => link,
        target              => '/var/named/chroot/run',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/dev':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/conf.d':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/zones.d':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/keys':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/namedb':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
    }

    file { '/var/named/chroot/namedb/master':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
    }

    file { '/var/named/chroot/namedb/slave':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
    }

    file { '/var/named/chroot/namedb/dynamic':
        ensure              => directory,
        owner               => 'named',
        group               => 'named',
    }
}
