class webservers (
) {
    include webservers::packages
    include webservers::accounting
    include webservers::config

    service { 'httpd':
        hasrestart          => true,
    }
}
