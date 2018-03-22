class baseconfig::systemctl (
) {
    service { 'xinetd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rexec':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rsh':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rlogin':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'ypbind':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'tftp':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'certmonger':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'cgconfig':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'cgred':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'cpuspeed':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'kdump':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'mdmonitor':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'messagebus':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'netconsole':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'oddjobd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'portreserve':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'qpidd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'quota_nld':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rdisc':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rhnsd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rhsmcertd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'saslauthd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'smartd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'nfslock':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'dovecot':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rpcgssd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rpcsvcgssd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'rpcidmapd':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'netfs':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'nfs':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'avahi-daemon':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'cups':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }

    service { 'irqbalance':
        ensure              => stopped,
        enable              => false,
        provider            => 'systemd'
    }
}
