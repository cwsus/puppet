class haproxy {
    include haproxy::packages

    include haproxy::groups
    include haproxy::users
    include haproxy::files

    service { 'haproxy':
        hasrestart          => true,
    }
}
