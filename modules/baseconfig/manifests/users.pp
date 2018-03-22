class baseconfig::users (
) {
    user { 'puppetadm':
        ensure              => present,
        name                => 'puppetadm',
        gid                 => 'users',
        groups              => [ 'sudoers', 'puppet' ],
        home                => '/home/puppetadm',
        managehome          => true,
        password            => '<password>',
        purge_ssh_keys      => true,
        shell               => '/bin/bash',
        system              => true,
        uid                 => 5000,
    }

    file { '/root/.wgetrc':
        ensure              => present,
        owner               => 'root',
        group               => 'root',
        source              => 'puppet:///modules/baseconfig/root/.wgetrc',
        mode                => '0600',
    }

    file { '/home/puppetadm/.ssh':
        ensure              => directory,
        owner               => 'puppetadm',
        group               => 'users',
        mode                => '0700',
    }

    file { '/home/puppetadm/.ssh/id_rsa':
        ensure              => present,
        owner               => 'puppetadm',
        group               => 'users',
        source              => 'puppet:///modules/baseconfig/home/puppetadm/.ssh/id_rsa',
        mode                => '0600',
    }

    ssh_authorized_key { 'puppetadm@puppet.caspersbox.com':
        ensure              => present,
        user                => 'puppetadm',
        type                => 'ssh-rsa',
        key                 => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDp8FT+ygQpqhiSXXK9P9A0Thgrtjv0kApYZ/sl06BwClKFFzBMEh8nmIj6ac3QPgW59WqwKRW/3rAtJOS/bYdjp9icDLkOjivx7xOAD9z4aLRP8u1J6XvIfhD7GJBGhuaj+Z+xGv6xWm1cFBjMczU7U+CfR2riUWIg06A6gSkFnPsMpbKsEX5w8G3+eYAl6P0o7vR4vHUkiQ4wVDXRXOP5ANfl+Dk1w3WDKUXViVZKb9Qc9tlCALJYuRYQ+PQi7lNvk3cJsRf6dG4D4yy+uSwsHAFKlHxHjrXtHcg6swF+3o2n2NOGDjewNQcKDHl7eh1BDmlim5t3Kozjx+UbZskMwliePxXvhl2p699yxlMf+PomQXwkrnxSfTWrgd8eya2pXsEYDezw/8KCHB05DeTx4nYHeeBuTHT4Z/aHVD8mv70rndessO1p5H4jI+HH3efK85To52Z7L76qzOixnEwsqdVG1wqcmreqqgrrxjkiUazzYVLrHHabzdqe9TuLbtVQFw6c1vU+zf9VoUeDJP/dTFECcXpsOjhDmiy+cC+p/QOANntz7VFF8JfMEX1su3t72rGYdwnfWkp2NQu95dGPqbIT+oGp9sKMfXNOnVKKo64DzQMipYgyfqz12TeA8pMc1TtpBlmobnEG+08gxNWDcapUWt2kp+OvlTfnMvR/MQ==',
    }

    user { 'kmhuntly':
        ensure              => present,
        home                => '/home/kmhuntly',
        shell               => '/bin/bash',
        gid                 => 'users',
        groups              => ['sudoers', 'sshusers'],
    }
}
