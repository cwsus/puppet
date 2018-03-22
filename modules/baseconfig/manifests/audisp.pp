class baseconfig::audisp (
) {
    file { '/etc/audisp/plugins.d/syslog.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/baseconfig/etc/audisp/plugins.d/syslog.conf',
    }
}
