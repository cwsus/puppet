class packages::networkd (
    $is_dhcp = lookup({"name" => "profile::packages::is_dhcp", value_type => Boolean, default_value => 'true'}),
    $ip_addr = lookup({"name" => "profile::packages::ip_addr", value_type => String, default_value => ''})
) {
    package { 'systemd-networkd':
        ensure              => installed,
    }

    package { 'systemd-resolved':
        ensure              => installed,
    }

    file { '/etc/systemd/network':
        ensure              => directory,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
    }

    file { '/etc/systemd/network/cws.network':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        content             => template('packages/network.erb'),
    }

    service { 'systemd-networkd':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }

    service { 'systemd-resolved':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
