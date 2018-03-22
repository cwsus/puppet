class caserver::config {
    file { '/etc/pki/CA/conf/openssl.cnf':
        ensure              => present,
        owner               => 'appadm',
        group               => 'appsrv',
        mode                => '0644',
        source              => 'puppet:///modules/caserver/etc/pki/CA/conf/openssl.cnf',
    }
}
