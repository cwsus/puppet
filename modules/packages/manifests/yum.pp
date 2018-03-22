class packages::yum (
) {
    package { 'yum-metadata-parser':
        ensure              => 'installed',
    }

    package { 'yum-plugin-aliases':
        ensure              => 'installed',
    }

    package { 'yum-plugin-auto-update-debug-info':
        ensure              => 'installed',
    }

    package { 'yum-plugin-changelog':
        ensure              => 'installed',
    }

    package { 'yum-plugin-fastestmirror':
        ensure              => 'installed',
    }

    package { 'yum-plugin-filter-data':
        ensure              => 'installed',
    }

    package { 'yum-plugin-fs-snapshot':
        ensure              => 'installed',
    }

    package { 'yum-plugin-keys':
        ensure              => 'installed',
    }

    package { 'yum-plugin-list-data':
        ensure              => 'installed',
    }

    package { 'yum-plugin-local':
        ensure              => 'installed',
    }

    package { 'yum-plugin-merge-conf':
        ensure              => 'installed',
    }

    package { 'yum-plugin-ovl':
        ensure              => 'installed',
    }

    package { 'yum-plugin-post-transaction-actions':
        ensure              => 'installed',
    }

    package { 'yum-plugin-priorities':
        ensure              => 'installed',
    }

    package { 'yum-plugin-protectbase':
        ensure              => 'installed',
    }

    package { 'yum-plugin-ps':
        ensure              => 'installed',
    }

    package { 'yum-plugin-remove-with-leaves':
        ensure              => 'installed',
    }

    package { 'yum-plugin-rpm-warm-cache':
        ensure              => 'installed',
    }

    package { 'yum-plugin-show-leaves':
        ensure              => 'installed',
    }

    package { 'yum-plugin-tmprepo':
        ensure              => 'installed',
    }

    package { 'yum-plugin-tsflags':
        ensure              => 'installed',
    }

    package { 'yum-plugin-upgrade-helper':
        ensure              => 'installed',
    }

    package { 'yum-plugin-verify':
        ensure              => 'installed',
    }

    package { 'yum-plugin-versionlock':
        ensure              => 'installed',
    }

    package { 'yum-rhn-plugin':
        ensure              => 'installed',
    }

    package { 'yum-updateonboot':
        ensure              => 'installed',
    }

    package { 'yum-utils':
        ensure              => 'installed',
    }

    package { 'deltarpm':
        ensure              => 'installed',
    }

    file { '/etc/systemd/system/yum-daily-update.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/yum-daily-update.timer',
    }

    file { '/etc/systemd/system/yum-daily-update.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/yum-daily-update.service',
    }

    file { '/etc/systemd/system/yum-weekly-update.timer':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/yum-weekly-update.timer',
    }

    file { '/etc/systemd/system/yum-weekly-update.service':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/yum-weekly-update.service',
    }

    service { 'yum-daily-update.timer':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }

    service { 'yum-weekly-update.timer':
        ensure              => running,
        enable              => true,
        provider            => systemd,
    }
}
