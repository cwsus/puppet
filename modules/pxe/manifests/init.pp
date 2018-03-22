class pxe {
    include pxe::directories
    include pxe::files
    include pxe::tcpwrappers
    include pxe::systemctl
    include pxe::systemd
}
