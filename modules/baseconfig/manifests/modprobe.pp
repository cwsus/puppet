class baseconfig::modprobe (
) {
    file { '/etc/modprobe.d/01-usbstorage.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/01-usbstorage.conf',
    }

    file { '/etc/modprobe.d/02-ipv6.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/02-ipv6.conf',
    }

    file { '/etc/modprobe.d/03-dccp.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/03-dccp.conf',
    }

    file { '/etc/modprobe.d/04-rds.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/04-rds.conf',
    }

    file { '/etc/modprobe.d/05-sctp.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/05-sctp.conf',
    }

    file { '/etc/modprobe.d/06-tipc.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/06-tipc.conf',
    }

    file { '/etc/modprobe.d/07-cramfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/07-cramfs.conf',
    }

    file { '/etc/modprobe.d/08-freevxfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/08-freevxfs.conf',
    }

    file { '/etc/modprobe.d/09-jffs2.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/09-jffs2.conf',
    }

    file { '/etc/modprobe.d/10-hfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/10-hfs.conf',
    }

    file { '/etc/modprobe.d/11-hfsplus.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/11-hfsplus.conf',
    }

    file { '/etc/modprobe.d/12-squashfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/12-squashfs.conf',
    }

    file { '/etc/modprobe.d/13-udf.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/13-udf.conf',
    }

    file { '/etc/modprobe.d/14-bluetooth.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/14-bluetooth.conf',
    }

    file { '/etc/modprobe.d/15-appletalk.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/15-appletalk.conf',
    }
}
