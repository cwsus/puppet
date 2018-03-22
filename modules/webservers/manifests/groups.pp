class webservers::groups {
    group { 'apache':
        ensure              => present,
    }
}
