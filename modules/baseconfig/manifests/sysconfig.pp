class baseconfig::sysconfig (
) {
    file { '/etc/sysconfig/init':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysconfig/init',
    }

    file { '/etc/sysconfig/prelink':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysconfig/prelink',
    }
}
