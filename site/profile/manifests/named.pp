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
    include named::service
}
