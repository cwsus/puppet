class dhcp {
    include dhcp::packages

    include dhcp::groups
    include dhcp::users
    include dhcp::service
}
