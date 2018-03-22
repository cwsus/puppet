class proxy::directories {
    $html_dirs = [ '/var/www', '/var/www/caspersbox.com', '/var/www/caspersbox.com/html' ]

    file { $html_dirs:
        ensure              => 'directory',
        owner               => 'webadm',
        group               => 'webadm',
        mode                => '0755',
    }
}
