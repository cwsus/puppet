class caserver::directories {
    file { '/etc/pki':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/certs':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/conf':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/crl':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/csr':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/db':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/newcerts':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/pfx':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }

    file { '/etc/pki/CA/private':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
    }
}

