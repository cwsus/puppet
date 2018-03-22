class pxe::users {
    user { 'vsftpd':
        ensure              => present,
        name                => 'vsftpd',
        gid                 => 'users',
        groups              => [ 'vsftpd', ],
        home                => '/var/ftp',
        managehome          => true,
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
        purge_ssh_keys      => true,
        shell               => '/sbin/nologin',
        system              => true,
        uid                 => 5000,
    }

    user { 'vsftpdadm':
        ensure              => present,
        name                => 'vsftpdadm',
        gid                 => 'users',
        groups              => [ 'vsftpd', ],
        home                => '/home/vsftpdadm',
        managehome          => true,
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
        purge_ssh_keys      => true,
        shell               => '/bin/bash',
        system              => true,
        uid                 => 5001,
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
