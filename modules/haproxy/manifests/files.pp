class haproxy::files {
    file { '/etc/haproxy/haproxy.cfg':
        ensure              => present,
        owner               => 'haproxy',
        group               => 'haproxy',
        mode                => '0644',
        source              => 'puppet:///modules/haproxy/etc/haproxy/haproxy.cfg',
    }
}
