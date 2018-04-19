class baseconfig::modprobe (
) {
    file { '/etc/modprobe.d/00-usbstorage.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-usbstorage.conf',
    }

    file { '/etc/modprobe.d/00-ipv6.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-ipv6.conf',
    }

    file { '/etc/modprobe.d/00-dccp.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-dccp.conf',
    }

    file { '/etc/modprobe.d/00-rds.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-rds.conf',
    }

    file { '/etc/modprobe.d/00-sctp.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-sctp.conf',
    }

    file { '/etc/modprobe.d/00-tipc.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-tipc.conf',
    }

    file { '/etc/modprobe.d/00-cramfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-cramfs.conf',
    }

    file { '/etc/modprobe.d/00-freevxfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-freevxfs.conf',
    }

    file { '/etc/modprobe.d/00-jffs2.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-jffs2.conf',
    }

    file { '/etc/modprobe.d/00-hfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-hfs.conf',
    }

    file { '/etc/modprobe.d/00-hfsplus.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-hfsplus.conf',
    }

    file { '/etc/modprobe.d/00-squashfs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-squashfs.conf',
    }

    file { '/etc/modprobe.d/00-udf.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-udf.conf',
    }

    file { '/etc/modprobe.d/00-bluetooth.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-bluetooth.conf',
    }

    file { '/etc/modprobe.d/00-appletalk.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/modprobe.d/00-appletalk.conf',
    }
}
