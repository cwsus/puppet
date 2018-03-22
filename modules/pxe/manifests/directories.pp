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
}
