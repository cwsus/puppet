class named::copyfiles {
    file { '/var/named/chroot/namedb/named.rfc1912.zones':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.rfc1912.zones',
    }

    file { '/var/named/chroot/etc/keys.d/named.root.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.root.key',
    }

    file { '/var/named/chroot/etc/keys.d/named.iscdlv.key':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.isdcdlv.key',
    }

    file { '/var/named/chroot/etc/zones.d/named.rfc1912.zones':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.rfc1912.zones',
    }

    file { '/var/named/chroot/namedb/named.localhost':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.localhost',
    }

    file { '/var/named/chroot/namedb/named.loopback':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.loopback',
    }

    file { '/var/named/chroot/namedb/named.empty':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.empty',
    }

    file { '/var/named/chroot/namedb/named.ca':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.ca',
    }
}
