class proxy::packages (
) {
    package { 'squid':
        ensure              => 'installed',
    }

    package { 'squidGuard':
        ensure              => 'installed',
    }
}
