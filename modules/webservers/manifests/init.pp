class webservers {
    include webservers::packages
    include webservers::groups
    include webservers::accounts
    include webservers::files

    service { 'httpd':
        hasrestart          => true,
    }
}
