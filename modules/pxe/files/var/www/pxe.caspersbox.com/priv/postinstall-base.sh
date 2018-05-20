#!/usr/bin/env bash
#==============================================================================
#
#          FILE:  default.ks
#         USAGE:  N/A
#   DESCRIPTION:  Default kickstart installation file
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kevin Huntly <kmhuntly@gmail.com>
#       COMPANY:  CWS NA
#       VERSION:  1.0
#       CREATED:  ---
#      REVISION:  ---
#
#==============================================================================
#==============================================================================
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#==============================================================================

#
# install type here!!
#
typeset INSTALL_TYPE="${1}";
typeset HOSTNAME=localhost.localdomain
typeset INSTALLTYPE=$(/bin/grep installtype /proc/cmdline | /bin/cut -d "=" -f 2);
typeset INSTALLCONF=$(/bin/grep installconf /proc/cmdline | /bin/cut -d "=" -f 2);
typeset HOSTNAME=$(/bin/grep hostname /proc/cmdline | /bin/cut -d "=" -f 2);
typeset VLAN=$(/bin/grep hostname /proc/cmdline | /bin/cut -d "=" -f 2);
typeset NWINFO=$(/bin/grep hostname /proc/cmdline | /bin/cut -d "=" -f 2);


typeset NETDEV=$(/bin/ip addr | /bin/grep "2:" | /bin/awk -F ":" '{print $2}' | /bin/sed -e "s/^ //g"

typeset VLANNAME=vlan20
typeset VLANID=20
typeset MACADDR=$(/sbin/ip addr show dev ${NETDEV} | /bin/grep ether | /bin/awk '{print $2}');
typeset IPADDR=
typeset NETMASK=27
typeset GATEWAY=192.168.20.1


[ -z "${NETDEV}" ] && exit 1;
[ -z "${HOSTNAME}" -o "${HOSTNAME}" == "localhost.localdomain" ] && exit 1;
[ -z "${VLANNAME}" ] && exit 1;
[ -z "${VLANID}" ] && exit 1;
[ -z "${MACADDR}" ] && exit 1;
[ -z "${IPADDR}" ] && exit 1;
[ -z "${NETMASK}" ] && exit 1;
[ -z "${GATEWAY}" ] && exit 1;

#
# nameservers - i think we need them
#
echo "nameserver 192.168.20.6" > /etc/resolv.conf
echo "nameserver 192.168.20.7" >> /etc/resolv.conf

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
echo "/dev/cdrom    /mnt/cdrom    iso9660 ro,noexec,nosuid,nodev,noauto    0 0" >> /etc/fstab
echo "/var/tmp      /tmp          none    rw,nodev,noexec,nosuid,bind      0 0" >> /etc/fstab
echo "tmpfs         /dev/shm      tmpfs   rw,nodev,noexec,nosuid           0 0" >> /etc/fstab
echo "proc          /proc         proc    rw,hidepid=2                     0 0" >> /etc/fstab

#
# mkdir
#
mkdir -pv /etc/systemd/network

#
# get our baseconfig here
#
/bin/wget -O /var/tmp/baseconfig.tar.gz http://pxe.caspersbox.com:8080/priv/baseconfig.tar.gz

#
# extract
#
/bin/cd /
/bin/gunzip /var/tmp/baseconfig.tar.gz
/bin/tar xf /var/tmp/baseconfig.tar

#
# update cfg
#
/bin/sed -e "s^@macaddress^${MACADDR}^g" -e "s^@name^${NETDEV}^g" -e "s^@vlan^${VLANID}^g" \
    -e "s^@ipaddr^${IPADDR}^g" -e "s^@netmask^${NETMASK}^g" \
    -e "s^@gateway^${GATEWAY}^g" /etc/systemd/network/network.network > /etc/systemd/network/${NETDEV}.network;
/bin/rm -f /etc/systemd/network/network.network;

/bin/sed -e "s^@vlanname^${VLANNAME}^g" -e "s^@vlanid^${VLANID}^g" \
    /etc/systemd/network/vlan.netdev > /etc/systemd/network/${VLANNAME}.netdev;
/bin/rm -f etc/systemd/network/vlan.netdev;

/bin/sed -e "s^@hostname^${HOSTNAME}^g" /etc/sysconfig/networking > /etc/sysconfig/networking.new
/bin/rm -f /etc/sysconfig/networking;
/bin/mv /etc/sysconfig/networking.new /etc/sysconfig/networking

/bin/sed -e "s^@macaddress^${MACADDR}^g" -e "s^@netdev^${NETDEV}^g" \
    /etc/udev/rules.d/network.persistent.rules > /etc/udev/rules.d/network.persistent.rules.new
/bin/mv /etc/systemd/network/network_persistent.rules.new /etc/systemd/network/network_persistent.rules;
/bin/rm -f /etc/systemd/network/network_persistent.rules.new;

#
# cleanup
#
/bin/rm -f /etc/baseconfig.tar
/bin/rm -f /var/tmp/baseconfig.tar.gz

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

#
# specials based on install type
#
case "${INSTALL_TYPE}" in
    [Ww][Ee][Bb]|[Ww][Ee][Bb][Ss][Ee][Rr][Vv][Ee][Rr])
        /bin/yum -y install httpd httpd-tools apr apr-util mod_ssl php python;
        /bin/wget -O /var/tmp/dhcp-config.tar.gz http://pxe.caspersbox.com:8080/priv/dhcp-config.tar.gz;
        ;;
    [Dd][Hh][Cc][Pp])
        /bin/yum -y install dhcp;
        /bin/wget -O /var/tmp/dhcp-config.tar.gz http://pxe.caspersbox.com:8080/priv/dhcp-config.tar.gz;
        ;;
    [Dd][Nn][Ss])
        /bin/yum -y install named-chroot;
        /bin/wget -O /var/tmp/named-config.tar.gz http://pxe.caspersbox.com:8080/priv/named-config.tar.gz;
        ;;
    *)
        echo "No install type provided!!";
        ;;
esac

