class packages::cron (
) {
    package { 'cronie':
        ensure              => 'installed',
    }

    package { 'crontabs':
        ensure              => 'installed',
    }

    file { '/etc/cron.daily/unowned':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
        source              => 'puppet:///modules/packages/etc/cron.daily/unowned',
    }

    file { '/etc/cron.allow':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/cron.allow',
    }

    file { '/etc/cron.deny':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/cron.deny',
    }

    file { '/etc/at.allow':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/at.allow',
    }

    file { '/etc/at.deny':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/at.deny',
    }

    service { 'crond':
        ensure              => running,
        enable              => true,
        provider            => 'systemd'
    }
}
