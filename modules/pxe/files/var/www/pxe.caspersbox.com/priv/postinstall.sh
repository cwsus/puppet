#!/bin/ksh
#==============================================================================
#
#          FILE:  createNewZone.sh
#         USAGE:  ./createNewZone.sh
#   DESCRIPTION:  Creates a skeleton zone file and directory structure
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kevin Huntly <kmhuntly@gmail.com>
#       COMPANY:  CaspersBox Web Services
#       VERSION:  1.0
#       CREATED:  ---
#      REVISION:  ---
#==============================================================================

typeset CNAME="$(/bin/basename "${0}")";

#
# post-install default tasks
#
typeset INSTALL_TYPE="$(/bin/grep install.type /proc/cmdline | /bin/cut -d "=" -f 2)";
typeset INSTALL_HOSTNAME="$(/bin/grep install.hostname /proc/cmdline | /bin/cut -d "=" -f 3);
typeset NETDEV="$(/bin/ip addr show | /bin/grep "2:" | /bin/awk '{print $2}' | /bin/cut -d ":" -f 1);
typeset HWADDR="${/bin/ip addr show dev ${NETDEV} | /bin/grep ether | /bin/awk '{print $2}')";

echo "${INSTALL_TYPE}"
echo "${INSTALL_HOSTNAME}"
echo "${NETDEV}"
echo "${HWADDR}"

[ -z "${INSTALL_HOSTNAME}" ] && typeset INSTALL_HOSTNAME="localhost.localdomain";

#
# nameservers - i think we need them
#
echo "nameserver 8.8.4.4" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

#
# import epel/puppet keys
#
/bin/rpmkeys --import http://ftp.cse.buffalo.edu/pub/epel/RPM-GPG-KEY-EPEL-7
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet
/bin/rpmkeys --import https://duo.com/RPM-GPG-KEY-DUO

#
# maybe we can yum update?
#
/bin/yum -y install epel-release https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

#
# update yum repos...
#
/bin/yum -y update

#
# if the above works then this should too...
#
/bin/yum -y install procenv systemd-networkd systemd-resolved rkhunter clamav clamav-data \
    clamav-filesystem clamav-lib clamav-scanner clamav-scanner-systemd clamav-unofficial-sigs \
    clamav-update yum-updateonboot yum-plugin-show-leaves yum-plugin-remove-with-leaves duo_unix \
    yum-plugin-ps yum-plugin-keys yum-plugin-upgrade-helper yum-plugin-merge-conf puppet google-authenticator

#
# add entries to fstab
#
echo "/dev/cdrom    /media/cdrom  iso9660 ro,noexec,nosuid,nodev,noauto    0 0" >> /etc/fstab
echo "/var/tmp      /tmp          none    rw,nodev,noexec,nosuid,bind      0 0" >> /etc/fstab
echo "tmpfs         /dev/shm      tmpfs   rw,nodev,noexec,nosuid           0 0" >> /etc/fstab
echo "proc          /proc         proc    rw,hidepid=2                     0 0" >> /etc/fstab

#
# mkdir
#
mkdir -pv /etc/systemd/network

#
# networking
#
echo "[Match]
MACAddress=$(/sbin/ip addr show dev ${NETDEV} | /bin/grep ether | /bin/awk '{print $2}')

[Link]
MACAddress=$(/sbin/ip addr show dev ${NETDEV} | /bin/grep ether | /bin/awk '{print $2}')
MTUBytes=1500

[Network]
Description=CWS
DHCP=ipv4" > /etc/systemd/network/${NETDEV}.network

echo "HOSTNAME=${INSTALL_HOSTNAME}
NETWORKING=yes
NETWORKING_IPV6=no
IPV6INIT=no
NOZEROCONF=yes" > /etc/sysconfig/networking

#
# udev
#
echo "SUBSYSTEM=="net", ATTR{address}=="${HWADDR}", NAME="${NETDEV}", DRIVERS=="?*"" > /etc/udev/rules.d/networking_persistent.rules

#
# get our baseconfig here
#
/bin/mkdir -pv /media/cdrom
/bin/cp -Rp /tmp/cdrom/postinstall/installdata/default/etc /etc
/bin/cp -Rp /tmp/cdrom/postinstall/installdata/default/usr /usr

#
# services
#
/bin/systemctl enable aide.timer
/bin/systemctl enable freshclam.timer
/bin/systemctl enable puppet-agent.timer
/bin/systemctl enable rkhunter-update.timer
/bin/systemctl enable yum-daily-update.timer
/bin/systemctl enable yum-weekly-update.timer
/bin/systemctl enable sshd.service
/bin/systemctl enable systemd-networkd.service
/bin/systemctl enable systemd-resolved.service

#
# masking
#
systemctl stop kdump.service
systemctl stop firewalld.service
systemctl disable kdump.service
systemctl disable firewalld.service
systemctl mask firewalld.service
systemctl mask ctrl-alt-del.target
systemctl mask kdump.service

#
# disable usb support and add audit
#
typeset CURRENT_GRUB_CMDLINE="$(/bin/grep GRUB_CMDLINE_LINUX /etc/default/grub)"
typeset NEW_GRUB_CMDLINE="$(echo ${CURRENT_GRUB_CMDLINE} | /bin/sed -e "s/\"$/ nousb audit=1\"/g")"
/bin/sed -ie "s/${CURRENT_GRUB_CMDLINE}/${NEW_GRUB_CMDLINE}/" /etc/default/grub

/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg

#
# remove default "sysadm" group
#
/sbin/usermod -g users -G sshusers,sudoers sysadm
/sbin/groupdel sysadm

#
# run puppet
#
/bin/puppet agent apply

#
# enable the service
#
/bin/systemctl enable puppet

#
# remove unused users
#
/sbin/userdel shutdown
/sbin/userdel halt
/sbin/userdel games
/sbin/userdel operator
/sbin/userdel ftp
/sbin/userdel news
/sbin/userdel gopher

#
# remove unused groups
#
/sbin/groupdel games

#
# permissions
#
/bin/chmod 640 /etc/syslog.conf /etc/security/access.conf /etc/crontab /etc/sysctl.conf
/bin/chmod -R 750 /var/log/audit /usr/share/logwatch/scripts/logwatch.pl /var/crash /etc/skel
/bin/chown -R root. /var/crash

#
# updates for clam/rkhunter
#
/bin/rkhunter --propupdate --update
/bin/freshclam -v

#
# aide init
#
/usr/sbin/aide --init
/bin/cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
/usr/sbin/aide --check

#
# prelinking
#
/bin/sed -i "s/PRELINKING=.*/PRELINKING=no/g" /etc/sysconfig/prelink
/sbin/prelink -ua

#===  FUNCTION  ===============================================================
#          NAME:  createIntranetSkeletonZone
#   DESCRIPTION:  Creates the necessary group folder, domain folders and creates
#                 skeleton zone files. Skeletons are then updated with the
#                 provided zone name.
#    PARAMETERS:  Parameters obtained via command-line flags
#          NAME:  usage for positive result, >1 for non-positive
#==============================================================================
function installDNSServices
{
    /bin/yum -y install named-chroot;
    typeset -i RETURN_CODE=0;
}

#===  FUNCTION  ===============================================================
#          NAME:  createIntranetSkeletonZone
#   DESCRIPTION:  Creates the necessary group folder, domain folders and creates
#                 skeleton zone files. Skeletons are then updated with the
#                 provided zone name.
#    PARAMETERS:  Parameters obtained via command-line flags
#          NAME:  usage for positive result, >1 for non-positive
#==============================================================================
function installDHCPServices
{
    /bin/yum -y install dhcp;
    typeset -i RETURN_CODE=0;
}

#===  FUNCTION  ===============================================================
#          NAME:  createInternetSkeletonZone
#   DESCRIPTION:  Creates the necessary group folder, domain folders and creates
#                 skeleton zone files. Skeletons are then updated with the
#                 provided zone name.
#    PARAMETERS:  Parameters obtained via command-line flags
#          NAME:  usage for positive result, >1 for non-positive
#==============================================================================
function installWebServices
{
    /bin/yum -y install httpd httpd-tools apr apr-util mod_ssl php python;
    typeset -i RETURN_CODE=0;
}

#===  FUNCTION  ===============================================================
#          NAME:  buildWorkingZone
#   DESCRIPTION:  Creates the zone file that the DNS servers will utilize during
#                 queries. Takes the previously configured file from the primary
#                 datacenter folder and adds required indicator flags, and then
#                 places the resultant file in the group root.
#    PARAMETERS:  None
#          NAME:  usage
#==============================================================================
function installProxyServices
{
    /bin/yum -y install squid squidGuard;
    typeset -i RETURN_CODE=0;
}

[ ${#} -eq 0 ] && typeset INSTALL_TYPE="default"

case "${INSTALL_TYPE}" in
    [Dd][Ee][Ff][Aa][Uu][Ll][Tt])
        exit 0;
        ;;
    [Dd][Nn][Ss])
        installDNSServices;
        exit ${?};
        ;;
    [Dd][Hh][Cc][Pp])
        installDHCPServices;
        exit ${?};
        ;;
    [Ww][Ee][Bb]|[Ww][Ee][Bb][Ss][Ee][Rr][Vv][Ee][Rr])
        installWebServices;
        exit ${?};
        ;;
    [Pp][Rr][Oo][Xx][Yy])
        installProxyServices;
        exit ${?};
        ;;
    *)
        exit 0;
        ;;
esac
