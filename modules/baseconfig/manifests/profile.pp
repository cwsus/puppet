class baseconfig::profile (
) {
    file { '/etc/profile.d/cws.sh':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/profile.d/cws.sh',
    }

    file { '/etc/rc.d/init.d/functions':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/rc.d/init.d/functions',
    }

    file { '/etc/bashrc':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/bashrc',
    }

    file { '/etc/csh.cshrc':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/csh.cshrc',
    }

    file { '/etc/profile':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/profile',
    }
}
