class profile::named (
) {
    include named::packages
    include named::groups
    include named::users
    include named::directories
    include named::copyfiles
    include named::cleanup
    include named::config
    include named::zones

    service { 'named-chroot':
        ensure              => 'running',
        enable              => true,
        provider            => 'systemd'
    }
}
