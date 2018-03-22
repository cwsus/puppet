class packages::prelink (
) {
    package { 'prelink':
        ensure              => 'installed',
    }

    exec { 'prelink':
        command             => '/usr/sbin/prelink -ua',
    }
}
