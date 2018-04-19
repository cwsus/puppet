class packages::system (
) {
    package { 'wget':
        ensure              => 'installed',
    }

    package { 'chkconfig':
        ensure              => 'installed',
    }

    package { 'curl':
        ensure              => 'installed',
    }

    package { 'less':
        ensure              => 'installed',
    }

    package { 'openssl':
        ensure              => 'installed',
    }

    package { 'procenv':
        ensure              => 'installed',
    }

    package { 'procps-ng':
        ensure              => 'installed',
    }

    package { 'psmisc':
        ensure              => 'installed',
    }

    package { 'telnet':
        ensure              => 'installed',
    }

    package { 'traceroute':
        ensure              => 'installed',
    }

    package { 'zip':
        ensure              => 'installed',
    }

    package { 'unzip':
        ensure              => 'installed',
    }

    package { 'lsof':
        ensure              => 'installed',
    }

    package { 'ksh':
        ensure              => 'installed',
    }

    package { 'file':
        ensure              => 'installed',
    }

    package { 'dos2unix':
        ensure              => 'installed',
    }

    package { 'authconfig':
        ensure              => 'installed',
    }

    package { 'bc':
        ensure              => 'installed',
    }

    package { 'rsync':
        ensure              => 'installed',
    }

    package { 'man-db':
        ensure              => 'installed',
    }

    package { 'man-pages':
        ensure              => 'installed',
    }

    package { 'bind-utils':
        ensure              => 'installed',
    }

    package { 'whois':
        ensure              => 'installed',
    }

    package { 'vlock':
        ensure              => 'installed',
    }

    package { 'screen':
        ensure              => 'installed',
    }

    package { 'tmux':
        ensure              => 'installed',
    }

    package { 'logwatch':
        ensure              => 'installed',
    }
}

