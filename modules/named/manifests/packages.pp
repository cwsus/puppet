class named::packages {
    package { 'bind':
        ensure              => 'installed',
    }

    package { 'bind-libs':
        ensure              => 'installed',
    }

    package { 'bind-chroot':
        ensure              => 'installed',
    }

    package { 'nagios-plugins-dig':
        ensure              => 'installed',
    }

    package { 'nagios-plugins-dns':
        ensure              => 'installed',
    }
}

