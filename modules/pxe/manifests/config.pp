class pxe::directories {
    file { '/var/lib/pxe':
        ensure              => directory,
        owner               => 'tftpd',
        group               => 'tftpd',
        mode                => '0755',
    }

    file { '/var/lib/images':
        ensure              => directory,
        owner               => 'tftpd',
        group               => 'tftpd',
        mode                => '0755',
    }

    file { '/var/lib/pxelinux.cfg':
        ensure              => directory,
        owner               => 'tftpd',
        group               => 'tftpd',
        mode                => '0755',
    }

    file { '/etc/hosts.allow':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/pxe/etc/hosts.allow',
    }

    file { '/var/lib/pxe/pxelinux.cfg/default':
        ensure              => present,
        owner               => 'tftpd',
        group               => 'tftpd',
        mode                => '0644',
        source              => 'puppet:///modules/pxe/var/lib/pxe/pxelinux.cfg/default',
    }
}
