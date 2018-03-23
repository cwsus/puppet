#
# build configuration
#
class named::config (
    $ismaster = lookup('profile::named::ismaster', {value_type => Boolean, default_value => 'false'})
    $masterserver = lookup('profile::named::masterserver', {value_type => String, default_value => undef})
    $servers = lookup('profile::named::servers', {value_type => Hash[String, String], default_value => undef})
) {
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

    #
    # generate keys here - don't just copy/paste them
    # and DONT store them in the fucking repo
    #
    file { '/usr/local/bin/make-dns-keys.sh':
        ensure              => present,
        owner               => 'named',
        group               => 'named',
        mode                => '0755',
        content             => template('named/make-dns-keys.erb'),
    }

    exec ('make-dns-keys':
        command             => '/usr/local/bin/make-dns-keys.sh',
        returns             => '0',
    }
}
