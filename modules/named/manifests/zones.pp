#
# named zone files
#
class named::zones (
) {
    file { '/var/named/chroot/etc/namedb/master/db.caspersbox.com':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/namedb/master/db.caspersbox.com',
    }

    file { '/var/named/chroot/etc/namedb/master/db.network.caspersbox.com':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/namedb/master/db.network.caspersbox.com',
    }

    file { '/var/named/chroot/etc/namedb/master/db.192.168.10.in-addr.arpa':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/namedb/master/db.192.168.10.in-addr.arpa',
    }

    file { '/var/named/chroot/etc/namedb/dynamic/db.dynamic.caspersbox.com':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/namedb/dynamic/db.dynamic.caspersbox.com',
    }
}
