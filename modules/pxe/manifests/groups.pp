class pxe::groups {
    group { 'tftpd':
        ensure              => present,
    }

    group { 'vsaftpd':
        ensure              => present,
    }
}
