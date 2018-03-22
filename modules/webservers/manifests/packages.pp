class webservers::packages {
    package { 'httpd':
        ensure              => 'installed',
    }

    package { 'httpd-tools':
        ensure              => 'installed',
    }
}
