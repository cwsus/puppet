class webservers::packages (
) {
    package { 'httpd':
        ensure              => 'installed',
    }

    package { 'httpd-tools':
        ensure              => 'installed',
    }

    file { '/etc/httpd/ssl.d/ca':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/etc/httpd/ssl.d/crt':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/etc/httpd/ssl.d/key':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/etc/httpd/conf.d/esolutions.caspersbox.com':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/etc/httpd/conf.d/proxysvc.caspersbox.com':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/www/esolutions.caspersbox.com/html':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/www/proxysvc.caspersbox.com/html':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/log/esolutions.caspersbox.com':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/log/proxysvc.caspersbox.com':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/run/httpd/esolutions.caspersbox.com/html':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/run/httpd/proxysvc.caspersbox.com/html':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

    file { '/var/cache/httpd':
        ensure              => directory,
        owner               => 'websrv',
        group               => 'webgrp',
        mode                => '0755',
    }

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

    file { '/etc/hosts.allow':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/httpd/etc/hosts.allow',
    }
}
