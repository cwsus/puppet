class pxe::files {
    file { '/var/lib/pxe/pxelinux.cfg/default':
        ensure              => present,
        owner               => 'tftpd',
        group               => 'tftpd',
        mode                => '0644',
        source              => 'puppet:///modules/pxe/var/lib/pxe/pxelinux.cfg/default',
    }
}
