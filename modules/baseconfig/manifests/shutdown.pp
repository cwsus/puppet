class baseconfig::shutdown (
) {
    file { '/etc/shutdown.allow':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0600',
        source              => 'puppet:///modules/baseconfig/etc/shutdown.allow',
    }

    file { '/etc/shutdown.deny':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0600',
        source              => 'puppet:///modules/baseconfig/etc/shutdown.deny',
    }
}
