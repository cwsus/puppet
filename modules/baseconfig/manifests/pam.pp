class baseconfig::pam (
) {
    file { '/etc/pam.d/sshd':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/pam.d/sshd',
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
