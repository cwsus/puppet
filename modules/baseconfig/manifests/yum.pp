class baseconfig::systemd (
) {
    file { '/etc/yum.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/yum.conf',
    }

    file { '/etc/yum.repos.d':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/yum.repos.d/CentOS-Base.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/yum.repos.d/CentOS-base.conf',
    }

    file { '/etc/yum.repos.d/epel.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/yum.repos.d/epel.conf',
    }
}
