class baseconfig::security (
) {
    file { '/etc/security/limits.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/security/limits.conf',
    }

    file { '/etc/security/pwquality.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/security/pwquality.conf',
    }

    file { '/etc/securetty':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/securetty',
    }
}
