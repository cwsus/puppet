class packages::pam (
) {
    package { 'pam_yubico':
        ensure              => 'installed',
    }

    file { '/etc/pam.d/local-auth':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/pam.d/local-auth',
    }

    file { '/etc/pam.d/system-auth-ac':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/pam.d/system-auth-ac',
    }

    file { '/etc/pam.d/password-auth-ac':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/pam.d/password-auth-ac',
    }
}
