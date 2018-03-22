class packages::vim (
) {
    package { 'vim-minimal':
        ensure              => 'installed',
    }

    package { 'vim-common':
        ensure              => 'installed',
    }

    package { 'vim-enhanced':
        ensure              => 'installed',
    }

    package { 'vim-filesystem':
        ensure              => 'installed',
    }
}

