class baseconfig::sysctl (
) {
    file { '/etc/sysctl.d/01-ipv4.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysctl.d/01-ipv4.conf',
    }

    file { '/etc/sysctl.d/02-ipv6.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysctl.d/02-ipv6.conf',
    }

    file { '/etc/sysctl.d/03-kernel.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysctl.d/03-kernel.conf',
    }

    file { '/etc/sysctl.d/04-fs.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysctl.d/04-fs.conf',
    }

    file { '/etc/sysctl.d/05-vm.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/sysctl.d/05-vm.conf',
    }
}
