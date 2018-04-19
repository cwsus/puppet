class webservers::groups (
) {
    group { 'apache':
        ensure              => present,
    }

    user { 'webadm':
        ensure              => present,
        home                => '/home/appadm',
        shell               => '/bin/bash',
        managehome          => true,
        gid                 => 'apache',
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
    }

    user { 'websrv':
        ensure              => present,
        home                => '/home/appsrv',
        shell               => '/sbin/nologin',
        managehome          => true,
        gid                 => 'apache',
        password            => '$1$bnZualnB$Tg.u83tiKMMsmE5wr1dZx1',
    }
}
