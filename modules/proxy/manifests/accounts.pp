class proxy::accounts {
    user { 'squid':
        ensure              => present,
        home                => '/home/squid',
        shell               => '/sbin/nologin',
        managehome          => true,
        gid                 => 'squid',
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
    }
}
