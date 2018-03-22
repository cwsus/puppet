class packages::sudo (
) {
    package { 'sudo':
        ensure              => 'installed',
    }

    file { '/etc/sudoers.d/sudoers':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/sudoers.d/sudoers',
    }
}

