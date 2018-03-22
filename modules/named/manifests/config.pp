class named::config {
    file { '/var/named/chroot/etc/localtime':
        ensure              => 'link',
        target              => '/etc/localtime',
    }

    file { '/var/named/chroot/etc/services':
        ensure              => 'link',
        target              => '/etc/services',
    }

    file { '/var/named/chroot/etc/protocols':
        ensure              => 'link',
        target              => '/etc/protocols',
    }

    file { '/var/named/chroot/etc/named.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/named.erb'),
    }

    file { '/var/named/chroot/etc/conf.d/transfer.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/transfer.erb'),
    }

    file { '/var/named/chroot/etc/zones.d/named.rfc1912.zones.zones':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/etc/zones.d/named.rfc1912.zones',
    }

    file { '/var/named/chroot/etc/zones.d/caspersbox.zones':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/caspersbox.erb'),
    }

    file { '/var/named/chroot/etc/conf.d/controls.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/controls.erb'),
    }

    file { '/var/named/chroot/etc/conf.d/logging.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/etc/conf.d/logging.conf',
    }

    file { '/var/named/chroot/etc/conf.d/rndc.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/rndc.erb'),
    }

    file { '/var/named/chroot/etc/keys.d/dhcp-key.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/dhcp-key.key',
    }

    file { '/var/named/chroot/etc/keys.d/rndc-key.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/rndc-key.key',
    }

    file { '/var/named/chroot/etc/keys.d/rndc-remote.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/rndc-remote.key',
    }

    file { '/var/named/chroot/etc/keys.d/xfer-key.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/xfer-key.key',
    }

    file { '/var/named/chroot/etc/keys.d/named.iscdlv.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/named.iscdlv.key',
    }

    file { '/var/named/chroot/etc/keys.d/named.root.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/named.root.key',
    }

    file { '/var/named/chroot/etc/keys.d/trusted-key.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0640',
        source              => 'puppet:///modules/named/etc/keys.d/trusted-key.key',
    }

    file { '/etc/rndc.conf':
        ensure              => link,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        target              => '/var/named/chroot/etc/conf.d/rndc.conf',
    }

    file { '/etc/named.conf':
        ensure              => link,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        target              => '/var/named/chroot/etc/conf.d/named.conf',
    }
}
