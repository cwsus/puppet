class packages::audit (
) {
    package { 'audit':
        ensure              => 'installed',
    }

    file { '/etc/audit/auditd.conf':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/audit/auditd.conf',
    }

    file { '/etc/audit/rules.d/audit.rules':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/audit/rules.d/audit.rules',
    }
}
