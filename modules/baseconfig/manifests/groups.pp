class baseconfig::groups (
) {
    group { 'users':
        ensure              => present,
    }

    group { 'sudoers':
        ensure              => present,
    }

    group { 'sshusers':
        ensure              => present,
    }
}
