#
# named profile. cleans/configured dns services
#
class profile::named (
) {
    exec { 'stop-named':
        command             => 'systemctl stop named-chroot',
        onlyif              => "test -e /var/named/chroot/var/run/named.pid",
        returns             => 0,
    }

    include named::params
    include named::packages
    include named::accounting
    include named::config
    include named::zones

    exec { 'start-named':
        command             => 'systemctl start named-chroot',
        created             => '/var/named/chroot/var/run/named.pid',
        onlyif              => "test ! -e /var/named/chroot/var/run/named.pid",
        returns             => 0,
    }
}
