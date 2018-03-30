class packages::ssh (
    $ip_addr = lookup({"name" => "profile::packages::ip_addr", value_type => String, default_value => ''})
) {
    package { 'openssh':
        ensure              => 'installed',
    }

    package { 'openssh-clients':
        ensure              => 'installed',
    }

    package { 'openssh-server':
        ensure              => 'installed',
    }

    package { 'openssh-askpass':
        ensure              => 'installed',
    }

    file { '/etc/ssh/sshd_config':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        content             => template('packages/sshd_config.erb'),
    }

    file { '/etc/ssh/sshd_banner':
        ensure              => link,
        target              => '/etc/issue',
    }

    file { '/usr/local/bin/make-ssh-keys.sh':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0755',
        source              => 'puppet:///modules/packages/usr/local/bin/make-ssh-keys.sh',
    }

    file { '/etc/systemd/system/sshd.service':
        ensure              => file,
        owner               => 'root',
        group               => 'root',
        mode                => '0644',
        source              => 'puppet:///modules/packages/etc/systemd/system/sshd.service',
    }

    service { 'sshd':
        ensure              => running,
        enable              => true,
        provider            => systemd,
        hasrestart          => true,
    }
}
