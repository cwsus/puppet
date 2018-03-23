#
# named package installation
#
class named::packages (
) {
    package { 'bind':
        ensure              => 'installed',
    }

    package { 'bind-libs':
        ensure              => 'installed',
    }

    package { 'bind-chroot':
        ensure              => 'installed',
    }

    package { 'nagios-plugins-dig':
        ensure              => 'installed',
    }

    package { 'nagios-plugins-dns':
        ensure              => 'installed',
    }

    exec { 'systemctl-enable-named':
        command             => '/usr/bin/systemctl enable named-chroot',
        creates             => '/usr/lib/systemd/system/named-chroot.service',
        returns             => '0',
        notify              => Service['named-chroot'],
    }
}
