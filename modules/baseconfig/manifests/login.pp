class baseconfig::login (
) {
    file { '/etc/login.defs':
        ensure              => present,
        owner               => 'puppetadm',
        group               => 'users',
        source              => 'puppet:///modules/accounts/etc/login.defs',
        mode                => '0600',
    }
}
