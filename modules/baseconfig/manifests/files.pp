class baseconfig::files (
) {
    file { '/etc/netconfig':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/netconfig',
    }
}
