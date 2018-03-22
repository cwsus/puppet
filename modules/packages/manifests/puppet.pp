class packages::puppet (
) {
    package { 'puppet':
        ensure              => 'installed',
    }

    file { '/etc/systemd/system/puppet-agent.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/puppet-agent.timer',
    }

    file { '/etc/systemd/system/puppet-agent.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/puppet-agent.service',
    }

    service { 'puppet':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
