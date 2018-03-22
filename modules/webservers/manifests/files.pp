class webservers::files {
    file { '/etc/sysconfig/httpd':
        ensure              => present,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        source              => 'puppet:///modules/webservers/etc/sysconfig/httpd',
    }

    file { '/etc/httpd/conf/httpd.conf':
        ensure              => present,
        owner               => 'apache',
        group               => 'apache',
        mode                => '0644',
        source              => 'puppet:///modules/webservers/etc/httpd/conf/httpd.conf',
    }
}
