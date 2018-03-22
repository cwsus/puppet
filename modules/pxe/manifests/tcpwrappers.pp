class pxe::tcpwrappers {
    file { '/etc/hosts.allow':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/pxe/etc/hosts.allow',
    }

    file { '/etc/hosts.deny':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/pxe/etc/hosts.deny',
    }
}
