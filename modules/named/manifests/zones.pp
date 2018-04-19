#
# named zone files
#
class named::zones (
) {
    #
    # base zones
    #
    exec { 'named.localhost':
        command             => 'mv /var/named/named.localhost /var/named/chroot/namedb/named.localhost',
        creates             => '/var/named/named.localhost',
        path                => '/bin',
        onlyif              => 'test -e /var/named/named.localhost',
    }

    exec { 'named.loopback':
        command             => 'mv /var/named/named.loopback /var/named/chroot/namedb/named.loopback',
        creates             => '/var/named/named.loopback',
        path                => '/bin',
        onlyif              => 'test -e /var/named/named.loopback',
    }

    exec { 'named.empty':
        command             => 'mv /var/named/named.empty /var/named/chroot/namedb/named.empty',
        creates             => '/var/named/named.loopback',
        path                => '/bin',
        onlyif              => 'test -e /var/named/named.empty',
    }

    exec { 'named.ca':
        command             => 'mv /var/named/named.ca /var/named/chroot/namedb/named.ca',
        creates             => '/var/named/named.ca',
        path                => '/bin',
        onlyif              => 'test -e /var/named/named.ca',
    }

    #
    # master zones
    #
    file { 'db.caspersbox.com':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.caspersbox.com',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.caspersbox.com',
    }

    file { 'db.network.caspersbox.com':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.network.caspersbox.com',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.network.caspersbox.com',
    }

    file { 'db.mgmt.caspersbox.com':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.mgmt.caspersbox.com',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.mgmt.caspersbox.com',
    }

    file { 'db.192.168.5.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.192.168.5.in-addr.arpa',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.192.168.5.in-addr.arpa',
    }

    file { 'db.192.168.6.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.192.168.6.in-addr.arpa','
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.192.168.6.in-addr.arpa',
    }

    file { 'db.192.168.20.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.192.168.20.in-addr.arpa','
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.192.168.20.in-addr.arpa',
    }

    file { 'db.192.168.30.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.192.168.30.in-addr.arpa','
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.192.168.30.in-addr.arpa',
    }

    file { 'db.192.168.40.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/master/db.192.168.40.in-addr.arpa','
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/master/db.192.168.40.in-addr.arpa',
    }

    #
    # dynamic zones
    #
    file { 'db.dynamic.caspersbox.com':
        ensure              => present,
        path                => '/var/named/chroot/namedb/dynamic/db.dynamic.caspersbox.com','
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/dynamic/db.dynamic.caspersbox.com',
    }

    file { 'db.192.168.10.in-addr.arpa':
        ensure              => present,
        path                => '/var/named/chroot/namedb/dynamic/db.192.168.10.in-addr.arpa',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/namedb/dynamic/db.192.168.10.in-addr.arpa',
    }

    #
    # etc/zones.d
    #
    file { 'chroot/etc/zones.d/caspersbox.zones':
        ensure              => present,
        path                => '/var/named/chroot/etc/zones.d/caspersbox.zones',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/caspersbox.erb'),
    }

    exec { "/var/named/chroot/etc/zones.d/named.rfc1912.zones":
        command             => 'mv /etc/named.rfc1912.zones /var/named/chroot/etc/zones.d/named.rfc1912.zones',
        creates             => '/var/named/chroot/etc/zones.d/named.rfc1912.zones',
        path                => '/bin',
        onlyif              => 'test -e /etc/named.rfc1912.zones',
    }
}
