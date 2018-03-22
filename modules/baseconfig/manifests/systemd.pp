class baseconfig::systemd (
) {
    file { '/etc/systemd/journald.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/systemd/journald.conf',
    }
}
