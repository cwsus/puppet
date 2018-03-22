class haproxy::groups {
    group { 'haproxy':
        ensure              => present,
    }
}
