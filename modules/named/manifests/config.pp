#
# build configuration
#
class named::config($username, $groupname, $ismaster, $masterserver, $servers)
{
    #
    # cleanup
    #
    file { "slave":
        ensure              => absent,
        path                => "/var/named/slave",
        recurse             => true,
        force               => true,
    }

    file { "dynamic":
        ensure              => absent,
        path                => "/var/named/dynamic",
        recurse             => true,
        force               => true,
    }

    file { "data":
        ensure              => absent,
        path                => "/var/named/data",
        recurse             => true,
        force               => true,
    }

    file { "/etc/hosts.allow":
        ensure              => present,
        path                => "/etc/hosts.allow",
        owner               => "root",
        group               => "root",
        mode                => "0644",
        source              => "puppet:///modules/named/etc/hosts.allow",
    }

    file { "/var/named":
        ensure              => directory,
        path                => "/var/named",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot":
        ensure              => directory,
        path                => "/var/named/chroot",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/dev":
        ensure              => directory,
        path                => "/var/named/chroot/dev",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/etc":
        ensure              => directory,
        path                => "/var/named/chroot/etc",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/etc/keys.d":
        ensure              => directory,
        path                => "/var/named/chroot/etc/keys.d",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/etc/zones.d":
        ensure              => directory,
        path                => "/var/named/chroot/etc/zones.d",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/etc/conf.d":
        ensure              => directory,
        path                => "/var/named/chroot/etc/conf.d",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/etc/acl.d":
        ensure              => directory,
        path                => "/var/named/chroot/etc/acl.d",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/namedb":
        ensure              => directory,
        path                => "/var/named/chroot/namedb",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/namedb/dynamic":
        ensure              => directory,
        path                => "/var/named/chroot/namedb/dynamic",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/namedb/master":
        ensure              => directory,
        path                => "/var/named/chroot/namedb/master",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/namedb/slave":
        ensure              => directory,
        path                => "/var/named/chroot/namedb/slave",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var":
        ensure              => directory,
        path                => "/var/named/chroot/var",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var/run":
        ensure              => directory,
        path                => "/var/named/chroot/var/run",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var/run/named":
        ensure              => directory,
        path                => "/var/named/chroot/var/run/named",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var/named":
        ensure              => directory,
        path                => "/var/named/chroot/var/named",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var/tmp":
        ensure              => directory,
        path                => "/var/named/chroot/var/tmp",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/var/log":
        ensure              => directory,
        path                => "/var/named/chroot/var/log",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/usr":
        ensure              => directory,
        path                => "/var/named/chroot/usr",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/usr/lib64":
        ensure              => directory,
        path                => "/var/named/chroot/usr/lib64",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/usr/lib64/bind":
        ensure              => directory,
        path                => "/var/named/chroot/usr/lib64/bind",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
    }

    file { "/var/named/chroot/run":
        ensure              => link,
        path                => "/var/named/chroot/run",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
        target              => "/var/named/chroot/var/run",
    }

    #
    # namedb
    #
    exec { "/var/named/chroot/namedb/namedb.localhost":
        command             => "mv /var/named/named.localhost /var/named/chroot/namedb/named.localhost",
        creates             => "/var/named/chroot/namedb/named.localhost",
        path                => "/bin",
        onlyif              => "test -e /var/named/named.localhost",
    }

    file { "/var/named/chroot/namedb/named.localhost":
        ensure              => present,
        path                => "/var/named/chroot/namedb/named.localhost",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    exec { "/var/named/chroot/namedb/namedb.loopback":
        command             => "mv /var/named/named.loopback /var/named/chroot/namedb/named.loopback",
        creates             => "/var/named/chroot/namedb/named.loopback",
        path                => "/bin",
        onlyif              => "test -e /var/named/named.loopback",
    }

    file { "/var/named/chroot/namedb/named.loopback":
        ensure              => present,
        path                => "/var/named/chroot/namedb/named.loopback",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    exec { "/var/named/chroot/namedb/namedb.empty":
        command             => "mv /var/named/named.empty /var/named/chroot/namedb/named.empty",
        creates             => "/var/named/chroot/namedb/named.empty",
        path                => "/bin",
        onlyif              => "test -e /var/named/named.empty",
    }

    file { "/var/named/chroot/namedb/named.empty":
        ensure              => present,
        path                => "/var/named/chroot/namedb/named.empty",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    exec { "/var/named/chroot/namedb/namedb.ca":
        command             => "mv /var/named/named.ca /var/named/chroot/namedb/named.ca",
        creates             => "/var/named/chroot/namedb/named.ca",
        path                => "/bin",
        onlyif              => "test -e /var/named/named.ca",
    }

    file { "/var/named/chroot/namedb/named.ca":
        ensure              => present,
        path                => "/var/named/chroot/namedb/named.ca",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    #
    # etc
    #
    file { "/var/named/chroot/etc/named":
        ensure              => absent,
        path                => "/var/named/chroot/etc/named",
        recurse             => true,
        force               => true,
    }

    file { "/var/named/chroot/etc/pki":
        ensure              => absent,
        path                => "/var/named/chroot/etc/pki",
        recurse             => true,
        force               => true,
    }

    file { "/var/named/chroot/etc/localtime":
        ensure              => link,
        path                => "/var/named/chroot/etc/localtime",
        target              => "/etc/localtime",
    }

    file { "/var/named/chroot/etc/services":
        ensure              => link,
        path                => "/var/named/chroot/etc/services",
        target              => "/etc/services",
    }

    file { "/var/named/chroot/etc/protocols":
        ensure              => link,
        path                => "/var/named/chroot/etc/protocols",
        target              => "/etc/protocols",
    }

    file { "/var/named/chroot/etc/named.conf":
        ensure              => present,
        path                => "/var/named/chroot/etc/named.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        content             => template("named/named.erb"),
    }

    file { "/etc/named.conf":
        ensure              => link,
        path                => "/etc/named.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        target              => "/var/named/chroot/etc/conf.d/named.conf",
        replace             => true,
    }

    #
    # etc/acl.d
    #
    file { "/var/named/chroot/etc/acl.d/cwsdhcp.acl":
        ensure              => present,
        path                => "/var/named/chroot/etc/acl.d/cwsdhcp.acl",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/var/named/chroot/etc/acl.d/cwsdhcp.acl",
    }

    file { "/var/named/chroot/etc/acl.d/cwsns.acl":
        ensure              => present,
        path                => "/var/named/chroot/etc/acl.d/cwsns.acl",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/var/named/chroot/etc/acl.d/cwsns.acl",
    }

    file { "/var/named/chroot/etc/acl.d/master.acl":
        ensure              => present,
        path                => "/var/named/chroot/etc/acl.d/master.acl",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/var/named/chroot/etc/acl.d/master.acl",
    }

    file { "/var/named/chroot/etc/acl.d/network.acl":
        ensure              => present,
        path                => "/var/named/chroot/etc/acl.d/network.acl",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/var/named/chroot/etc/acl.d/network.acl",
    }

    #
    # etc/conf.d
    #
    file { "/var/named/chroot/etc/conf.d/transfer.conf":
        ensure              => present,
        path                => "/var/named/chroot/etc/conf.d/transfer.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        content             => template("named/transfer.erb"),
    }

    file { "/var/named/chroot/etc/conf.d/controls.conf":
        ensure              => present,
        path                => "/var/named/chroot/etc/conf.d/controls.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        content             => template("named/controls.erb"),
    }

    file { "/var/named/chroot/etc/conf.d/logging.conf":
        ensure              => present,
        path                => "/var/named/chroot/etc/conf.d/logging.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/var/named/chroot/etc/conf.d/logging.conf",
    }

    file { "/var/named/chroot/etc/conf.d/rndc.conf":
        ensure              => present,
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        content             => template("named/rndc.erb"),
    }

    file { "/etc/rndc.conf":
        ensure              => link,
        path                => "/etc/rndc.conf",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        target              => "/var/named/chroot/etc/conf.d/rndc.conf",
        replace             => true,
    }

    #
    # keys.d
    #
    #
    # at some point, may want to change to wget from ISC
    # https://ftp.isc.org/isc/bind9/keys/9.11/bind.keys.v9_11
    #
    exec { "/var/named/chroot/etc/keys.d/named.root.key":
        command             => "mv /etc/named.root.key /var/named/chroot/etc/keys.d/named.root.key",
        creates             => "/var/named/chroot/etc/keys.d/named.root.key",
        path                => "/bin",
        onlyif              => "test -e /etc/named.root.key",
    }

    file { "/var/named/chroot/etc/keys.d/named.root.key":
        ensure              => present,
        path                => "/var/named/chroot/etc/keys.d/named.root.key",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    exec { "/var/named/chroot/etc/keys.d/named.iscdlv.key":
        command             => "mv /etc/named.root.key /var/named/chroot/etc/keys.d/named.iscdlv.key",
        creates             => "/var/named/chroot/etc/keys.d/named.iscdlv.key",
        path                => "/bin",
        onlyif              => "test -e /etc/named.iscdlv.key",
    }

    file { "/var/named/chroot/etc/keys.d/named.iscdlv.key":
        ensure              => present,
        path                => "/var/named/chroot/etc/keys.d/named.iscdlv.key",
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
    }

    #
    # var/log
    #
    file { "/var/log/named":
        ensure              => link,
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
        target              => "/var/named/chroot/var/log",
    }

    #
    # generate keys here - don"t just copy/paste them
    # and DONT store them in the fucking repo
    #
    file { "/usr/local/bin/make-dns-keys.sh":
        ensure              => present,
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0755",
        source              => "puppet:///modules/named/usr/local/bin/make-dns-keys.sh",
    }

    file { "/usr/local/etc/make-dns-keys.conf":
        ensure              => present,
        owner               => "${username}",
        group               => "${groupname}",
        mode                => "0644",
        source              => "puppet:///modules/named/usr/local/etc/make-dns-keys.conf",
    }

    exec { "make-dns-keys":
        command             => "/usr/local/bin/make-dns-keys.sh",
        returns             => "0",
    }
}

