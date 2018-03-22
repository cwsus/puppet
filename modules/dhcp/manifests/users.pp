class dhcp::users {
    user { 'dhcp':
        ensure              => present,
        home                => '/home/dhcp',
        shell               => '/sbin/nologin',
        managehome          => true,
        gid                 => 'dhcp',
        password            => '$1$wKeA3qku$27JdkurO/iQRtVvnTYCWQ0',
    }
}

