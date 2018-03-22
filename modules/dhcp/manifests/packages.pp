class dhcp::packages {
    package { 'dhcp':
        ensure              => 'installed',
    }

    package { 'dhcping':
        ensure              => 'installed',
    }

    package { 'nagios-plugins-dhcp':
        ensure              => 'installed',
    }
}

