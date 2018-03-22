class haproxy::vips {
    file { '/etc/systemd/network/15-eth1.network':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/haproxy/etc/systemd/network/15-eth1.network',
    }
}