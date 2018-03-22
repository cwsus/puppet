class haproxy::users {
    user { 'haproxy':
        ensure              => present,
        home                => '/home/haproxy',
        shell               => '/sbin/nologin',
        managehome          => true,
        gid                 => 'haproxy',
        password            => '$1$Dsmsdlyu$pMhZMM6HqtafrHj8CHA6u1',
    }
}
