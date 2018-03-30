#
# build configuration
#
class named::config (
    $ismaster = lookup('profile::named::ismaster', {value_type => Boolean, default_value => false}),
    $masterserver = lookup('profile::named::masterserver', {value_type => String, default_value => ''}),
    $servers = lookup('profile::named::servers', {value_type => Hash, default_value => ''})
) {
    file { '/var/named':
        ensure              => directory,
        path                => '/var/named',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot':
        ensure              => directory,
        path                => '/var/named/chroot',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/dev':
        ensure              => directory,
        path                => '/var/named/chroot/dev',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc':
        ensure              => directory,
        path                => '/var/named/chroot/etc',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/keys.d':
        ensure              => directory,
        path                => '/var/named/chroot/etc/keys.d',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/zones.d':
        ensure              => directory,
        path                => '/var/named/chroot/etc/zones.d',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/conf.d':
        ensure              => directory,
        path                => '/var/named/chroot/etc/conf.d',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/etc/acl.d':
        ensure              => directory,
        path                => '/var/named/chroot/etc/acl.d',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/namedb':
        ensure              => directory,
        path                => '/var/named/chroot/namedb',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/namedb/dynamic':
        ensure              => directory,
        path                => '/var/named/chroot/namedb/dynamic',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/namedb/master':
        ensure              => directory,
        path                => '/var/named/chroot/namedb/master',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/namedb/slave':
        ensure              => directory,
        path                => '/var/named/chroot/namedb/slave',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var':
        ensure              => directory,
        path                => '/var/named/chroot/var',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/run':
        ensure              => directory,
        path                => '/var/named/chroot/var/run',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/run/named':
        ensure              => directory,
        path                => '/var/named/chroot/var/run/named',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/named':
        ensure              => directory,
        path                => '/var/named/chroot/var/named',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/tmp':
        ensure              => directory,
        path                => '/var/named/chroot/var/tmp',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/var/log':
        ensure              => directory,
        path                => '/var/named/chroot/var/log',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr':
        ensure              => directory,
        path                => '/var/named/chroot/usr',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr/lib64':
        ensure              => directory,
        path                => '/var/named/chroot/usr/lib64',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/usr/lib64/bind':
        ensure              => directory,
        path                => '/var/named/chroot/usr/lib64/bind',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
    }

    file { '/var/named/chroot/run':
        ensure              => link,
        path                => '/var/named/chroot/run',
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
        target              => '/var/named/chroot/var/run',
    }

    #
    # namedb
    #
    file { '/var/named/chroot/namedb/named.localhost':
        ensure              => present,
        path                => '/var/named/chroot/namedb/named.localhost',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.localhost',
    }

    file { '/var/named/named.localhost':
        ensure              => absent,
        path                => '/var/named/named.localhost',
    }

    file { '/var/named/chroot/namedb/named.loopback':
        ensure              => present,
        path                => '/var/named/chroot/namedb/named.loopback',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.loopback',
    }

    file { '/var/named/named.loopback':
        ensure              => absent,
        path                => '/var/named/named.loopback',
    }

    file { '/var/named/chroot/namedb/named.empty':
        ensure              => present,
        path                => '/var/named/chroot/namedb/named.empty',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.empty',
    }

    file { '/var/named/named.empty':
        ensure              => absent,
        path                => '/var/named/named.empty',
    }

    file { '/var/named/chroot/namedb/named.ca':
        ensure              => present,
        path                => '/var/named/chroot/namedb/named.ca',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///var/named/named.ca',
    }

    file { '/var/named/named.ca':
        ensure              => absent,
        path                => '/var/named/named.ca',
    }

    #
    # etc
    #
    file { '/var/named/chroot/etc/named':
        ensure              => absent,
        path                => '/var/named/chroot/etc/named',
        recurse             => true,
        force               => true,
    }

    file { '/var/named/chroot/etc/pki':
        ensure              => absent,
        path                => '/var/named/chroot/etc/pki',
        recurse             => true,
        force               => true,
    }

    file { '/var/named/chroot/etc/localtime':
        ensure              => link,
        path                => '/var/named/chroot/etc/localtime',
        target              => '/etc/localtime',
    }

    file { '/var/named/chroot/etc/services':
        ensure              => link,
        path                => '/var/named/chroot/etc/services',
        target              => '/etc/services',
    }

    file { '/var/named/chroot/etc/protocols':
        ensure              => link,
        path                => '/var/named/chroot/etc/protocols',
        target              => '/etc/protocols',
    }

    file { '/var/named/chroot/etc/named.conf':
        ensure              => present,
        path                => '/var/named/chroot/etc/named.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/named.erb'),
    }

    file { '/etc/named.conf':
        ensure              => link,
        path                => '/etc/named.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        target              => '/var/named/chroot/etc/conf.d/named.conf',
        replace             => true,
    }

    #
    # etc/acl.d
    #
    file { '/var/named/chroot/etc/acl.d/cwsdhcp.acl':
        ensure              => present,
        path                => '/var/named/chroot/etc/acl.d/cwsdhcp.acl',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/etc/acl.d/cwsdhcp.acl',
    }

    file { '/var/named/chroot/etc/acl.d/cwsns.acl':
        ensure              => present,
        path                => '/var/named/chroot/etc/acl.d/cwsns.acl',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/etc/acl.d/cwsns.acl',
    }

    file { '/var/named/chroot/etc/acl.d/master.acl':
        ensure              => present,
        path                => '/var/named/chroot/etc/acl.d/master.acl',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/etc/acl.d/master.acl',
    }

    file { '/var/named/chroot/etc/acl.d/network.acl':
        ensure              => present,
        path                => '/var/named/chroot/etc/acl.d/network.acl',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/etc/acl.d/network.acl',
    }

    #
    # etc/conf.d
    #
    file { '/var/named/chroot/etc/conf.d/transfer.conf':
        ensure              => present,
        path                => '/var/named/chroot/etc/conf.d/transfer.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/transfer.erb'),
    }

    file { '/var/named/chroot/etc/conf.d/controls.conf':
        ensure              => present,
        path                => '/var/named/chroot/etc/conf.d/controls.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/controls.erb'),
    }

    file { '/var/named/chroot/etc/conf.d/logging.conf':
        ensure              => present,
        path                => '/var/named/chroot/etc/conf.d/logging.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/var/named/chroot/etc/conf.d/logging.conf',
    }

    file { '/var/named/chroot/etc/conf.d/rndc.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/rndc.erb'),
    }

    file { '/etc/rndc.conf':
        ensure              => link,
        path                => '/etc/rndc.conf',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        target              => '/var/named/chroot/etc/conf.d/rndc.conf',
        replace             => true,
    }

    #
    # keys.d
    #
    #
    # at some point, may want to change to wget from ISC
    # https://ftp.isc.org/isc/bind9/keys/9.11/bind.keys.v9_11
    #
    file { '/var/named/chroot/etc/keys.d/named.root.key':
        ensure              => present,
        path                => '/var/named/chroot/etc/keys.d/named.root.key',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.root.key',
    }

    file { '/etc/named.root.key':
        ensure              => absent,
        path                => '/etc/named.root.key',
    }

    file { '/var/named/chroot/etc/keys.d/named.iscdlv.key':
        ensure              => present,
        path                => '/var/named/chroot/etc/keys.d/named.iscdlv.key',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.isdcdlv.key',
    }

    file { '/etc/named.iscdlv.key':
        ensure              => absent,
        path                => '/etc/named.iscdlv.key',
    }

    #
    # etc/zones.d
    #
    file { '/var/named/chroot/etc/zones.d/caspersbox.zones':
        ensure              => present,
        path                => '/var/named/chroot/etc/zones.d/caspersbox.zones',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        content             => template('named/caspersbox.erb'),
    }

    file { '/var/named/chroot/etc/zones.d/named.rfc1912.zones':
        ensure              => present,
        path                => '/var/named/chroot/etc/zones.d/named.rfc1912.zones',
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'file:///etc/named.rfc1912.zones',
    }

    file { '/etc/named.rfc1912.zones':
        ensure              => absent,
        path                => '/etc/named.rfc1912.zones',
    }

    #
    # var/log
    #
    file { '/var/log/named':
        ensure              => link,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
        target              => '/var/named/chroot/var/log',
    }

    #
    # generate keys here - don't just copy/paste them
    # and DONT store them in the fucking repo
    #
    file { '/usr/local/bin/make-dns-keys.sh':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
        source              => 'puppet:///modules/named/usr/local/bin/make-dns-keys.sh',
    }

    file { '/usr/local/etc/make-dns-keys.conf':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0644',
        source              => 'puppet:///modules/named/usr/local/etc/make-dns-keys.conf',
    }

    exec { 'make-dns-keys':
        command             => '/usr/local/bin/make-dns-keys.sh',
        returns             => '0',
    }
}
