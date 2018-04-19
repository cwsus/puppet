class pxe::users (
) {
    group { 'tftpd':
        ensure              => present,
    }

    user { 'tftpd':
        ensure              => present,
        name                => 'tftpd',
        gid                 => 'users',
        groups              => [ 'tftpd', ],
        home                => '/var/lib/pxe',
        managehome          => true,
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
        purge_ssh_keys      => true,
        shell               => '/sbin/nologin',
        system              => true,
        uid                 => 5002,
    }
}
