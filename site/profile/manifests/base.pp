class profile::base {
    package { 'epel-release':
        ensure              => 'installed',
    }

    include packages::aide
    include packages::audit
    include packages::chrony
    include packages::clamav
    include packages::cron
    include packages::puppet
    include packages::rkhunter
    include packages::ssh
    include packages::sudo
    include packages::sysstat
    include packages::system
    include packages::networkd
    include packages::tcpwrappers
    include packages::vim
    include packages::yum
    include packages::psacct
    include baseconfig::accounting
    include baseconfig::audisp
    include baseconfig::files
    include baseconfig::login
    include baseconfig::modprobe
    include baseconfig::pam
    include baseconfig::profile
    include baseconfig::security
    include baseconfig::shutdown
    include baseconfig::sysconfig
    include baseconfig::sysctl
    include baseconfig::systemctl
    include baseconfig::systemd

    exec { 'systemd-reload':
        command             => '/usr/bin/env systemctl daemon-reload',
    }

    exec { 'systemd-reexec':
        command             => '/usr/bin/env systemctl daemon-reexec',
    }
}

