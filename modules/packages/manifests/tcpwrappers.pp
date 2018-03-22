class packages::tcpwrappers (
) {
    package { 'tcp_wrappers':
        ensure              => 'installed',
    }

    file { '/etc/hosts.allow':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/hosts.allow',
    }

    file { '/etc/hosts.deny':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/hosts.deny',
    }
}
