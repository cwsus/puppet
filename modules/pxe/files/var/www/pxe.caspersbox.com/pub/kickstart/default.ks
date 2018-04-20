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

#version=DEVEL
#
# System authorization information
#
auth --enableshadow --passalgo=sha512

#
# we want an install
#
text
install
url --url http://pxe.caspersbox.com/pub/centos/7/os/x86_64

#
# Run the Setup Agent on first boot
#
firstboot --disable

#
# standard groups
#
group --name=sudoers  --gid=5000
group --name=sshusers --gid=5001

#
# Create sysadm user
#
user --uid=5000 --groups=wheel,sshusers,sudoers --name=sysadm --password=<password>

#
# reboot after install
#
reboot

#
# Keyboard layouts
#
keyboard --vckeymap=us --xlayouts='us'

#
# System language
#
lang en_US.UTF-8

#
# Network information
#
network --device=bootif --bootproto=dhcp --ethtool="autoneg on lro off" --noipv6 --activate --onboot=yes
network --hostname=localhost.localdomain

#
# disable firewall/selinux
#
firewall --disabled
selinux --permissive

#
# no X
#
skipx

#
# accept agreement
#
eula --agreed

#
# enable chrony
#
services --enabled="chronyd"

#
# Root password
#
rootpw --iscrypted <password>

#
# System timezone
#
timezone --isUtc America/New_York --ntpservers=ntp.caspersbox.com

#
# disk
#
ignoredisk --only-use=sda

#
# System bootloader configuration
#
bootloader --location=mbr --boot-drive=sda --timeout=3 --iscrypted --password=grub.pbkdf2.sha512.<password>
zerombr

#
# Partition clearing information
#
clearpart --all --initlabel

#
# boot partition
#
part /boot --fstype="ext2" --ondisk=sda --size=512 --label=boot --mkfsoptions="-m 0" --fsoptions="rw,nodev,noexec,nosuid"

#
# 15GB physical volume on /dev/sda
#
part pv.01 --fstype="lvmpv" --ondisk=sda --size=14077
volgroup centos --pesize=4096 pv.01

#
# logical volumes
#
logvol /              --fstype="ext4"  --size=4096 --vgname=centos --name=lv_root      --label=lv_root      --mkfsoptions="-m 1"
logvol /home          --fstype="ext4"  --size=100  --vgname=centos --name=lv_home      --label=lv_home      --mkfsoptions="-m 0" --fsoptions="rw,nodev,nosuid"
logvol /tmp           --fstype="ext4"  --size=1024 --vgname=centos --name=lv_tmp       --label=lv_tmp       --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var           --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var       --label=lv_var       --mkfsoptions="-m 1" --fsoptions="rw,nosuid"
logvol /var/cache     --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-cache --label=lv_var-cache --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/log       --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-log   --label=lv_var-log   --mkfsoptions="-m 0" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/log/audit --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-audit --label=lv_var-audit --mkfsoptions="-m 0" --fsoptions="rw,nodev,noexec,nosuid"
logvol swap           --fstype="swap"  --size=3072 --vgname=centos --name=lv_swap      --label=lv_swap                           --fsoptions="swap"

#
# add extra repos
#
repo --name=CentOS-Extras --mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
repo --name=epel-release  --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch --install

#
# Package Installation
#
%packages
@^minimal
@core --nodefaults
@base --nodefaults
chrony
openscap
openscap-scanner
rsyslog
scap-security-guide
sudo
prelink
vim-minimal
vim-common
vim-enhanced
vim-filesystem
wget
chkconfig
cronie
crontabs
curl
less
nmap
openssl
telnet
traceroute
zip
unzip
apr
apr-util
lsof
ksh
file
dos2unix
authconfig
bc
deltarpm
rsync
man-db
man-pages
bind-utils
whois
chrony
openssh
openssh-clients
openssh-server
openssh-askpass
psmisc
procps-ng
screen
vlock
logwatch
sysstat
aide
audit
psacct
yum-utils
yum-plugin-fastestmirror
yum-plugin-verify
tcpdump
tmux
-kexec-tools
-aic94xx-firmware*
-alsa-*
-biosdevname
-btrfs-progs*
-dracut-network
-iprutils
-ivtv*
-iwl*firmware
-libertas*
-kexec-tools
-ModemManager-*
-NetworkManager*
-ntp*
-plymouth*
-postfix
-tuned
-wpa_supplicant
-compiz
-emacs-leim
-emacspeak
-ethereal
-ethereal-gnome
-gnome-games
-isdn4k-utils
-nmap
-octave
-oprofile
-rcs
-valgrind
-zsh
-fxload
-libndp
-lsscsi
-lzo
-mariadb-libs
-python-configobj
-python-linux-procfs
-python-perf
-python-pyudev
-python-schedutils
-snappy
-teamd
-virt-what
-jansson
-libdaemon
-libteam
-libnl3-cli
-libnl3
-libsysfs
-yum-plugin-filter-data
-yum-plugin-list-data
-libusbx
-libyubikey
-pam_yubico
-ykclient
-ykpers
%end

%addon org_fedora_oscap
    content-type = scap-security-guide
    profile = common
%end

%addon com_redhat_kdump --disable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end

# Start of the %post section with logging into /root/ks-post.log
%post --log=/root/ks-post.log

#==============================================================================
#
# BASE HARDENING
#
#==============================================================================
#
# add entries to fstab
#
echo "/dev/cdrom    /mnt/cdrom    iso9660 ro,noexec,nosuid,nodev,noauto    0 0" >> /etc/fstab
echo "/var/tmp      /tmp          none    rw,nodev,noexec,nosuid,bind      0 0" >> /etc/fstab
echo "tmpfs         /dev/shm      tmpfs   rw,nodev,noexec,nosuid           0 0" >> /etc/fstab
echo "proc          /proc         proc    rw,hidepid=2                     0 0" >> /etc/fstab

#
# 2.2 Restrict Dynamic Mounting and Unmounting of Filesystems
#
printf "blacklist usb-storage\n" >> /etc/modprobe.d/00-usbstorage.conf
printf "blacklist firewire-core\n" >> /etc/modprobe.d/00-usbstorage.conf
printf "install usb-storage /bin/false\n" >> /etc/modprobe.d/00-usbstorage.conf
printf "options ipv6 disable=1\n" > /etc/modprobe.d/00-ipv6.conf
printf "install dccp /bin/false\n" > /etc/modprobe.d/00-dccp.conf
printf "install rds /bin/false\n" > /etc/modprobe.d/00-rds.conf
printf "install sctp /bin/false\n" > /etc/modprobe.d/00-sctp.conf
printf "install tipc /bin/false\n" > /etc/modprobe.d/00-tipc.conf
printf "install cramfs /bin/false\n" > /etc/modprobe.d/00-cramfs.conf
printf "install freevxfs /bin/false\n" > /etc/modprobe.d/00-freevxfs.conf
printf "install jffs2 /bin/false\n" > /etc/modprobe.d/00-jffs2.conf
printf "install hfs /bin/false\n" > /etc/modprobe.d/00-hfs.conf
printf "install hfsplus /bin/false\n" >> /etc/modprobe.d/00-hfs.conf
printf "install squashfs /bin/false > /etc/modprobe.d/00-squashfs.conf
printf "install udf /bin/false > /etc/modprobe.d/00-udf.conf
printf "install bnep /bin/false\n" > /etc/modprobe.d/00-bluetooth.conf
printf "install bluetooth /bin/false\n" >> /etc/modprobe.d/00-bluetooth.conf
printf "install btusb /bin/false\n" >> /etc/modprobe.d/00-bluetooth.conf
printf "install net-pf-31 /bin/false\n" >> /etc/modprobe.d/00-bluetooth.conf
printf "install appletalk /bin/false\n" > /etc/modprobe.d/00-appletalk.conf
printf "install fat /bin/false\n" > /etc/modprobe.d/00-fat.conf
printf "install vfat /bin/false\n" >> /etc/modprobe.d/00-fat.conf
printf "install cifs /bin/false\n" > /etc/modprobe.d/00-cifs.conf
printf "install nfs /bin/false\n" > /etc/modprobe.d/00-nfs.conf
printf "install nfsv3 /bin/false\n" >> /etc/modprobe.d/00-nfs.conf
printf "install nfsv4 /bin/false\n" >> /etc/modprobe.d/00-nfs.conf
printf "install gfs2 /bin/false\n" > /etc/modprobe.d/00-gfs2.conf

#
# Disable USB authorisation. Create a file /opt/usb-auth.sh with the following content:
#
printf "#!/bin/bash\n" > /usr/local/bin/usbauth.sh
printf "echo 0 > /sys/bus/usb/devices/usb1/authorized\n" >> /usr/local/bin/usbauth.sh
printf "echo 0 > /sys/bus/usb/devices/usb1/authorized_default\n" >> /usr/local/bin/usbauth.sh

/bin/chmod 0755 /usr/local/bin/usbauth.sh

printf "[Unit]\n" > /etc/systemd/system/usb-auth.service
printf "Description=Disable USB auth\n" >> /etc/systemd/system/usb-auth.service
printf "DefaultDependencies=no\n" >> /etc/systemd/system/usb-auth.service
printf "\n" >> /etc/systemd/system/usb-auth.service
printf "[Service]\n" >> /etc/systemd/system/usb-auth.service
printf "Type=oneshot\n" >> /etc/systemd/system/usb-auth.service
printf "ExecStart=/bin/bash /usr/local/bin/usbauth.sh\n" >> /etc/systemd/system/usb-auth.service
printf "\n" >> /etc/systemd/system/usb-auth.service
printf "[Install]\n" >> /etc/systemd/system/usb-auth.service
printf "WantedBy=multi-user.target\n" >> /etc/systemd/system/usb-auth.service
printf "\n" >> /etc/systemd/system/usb-auth.service

/bin/systemctl enable usb-auth.service
/bin/systemctl start usb-auth.service

#
# 2.4 Restrict Programs from Dangerous Execution Patterns
#
printf "# core tcp tune\n" >> 01-ipv4.conf
printf "net.core.rmem_max = 16777216\n" >> 01-ipv4.conf
printf "net.core.wmem_max = 16777216\n" >> 01-ipv4.conf
printf "net.core.netdev_max_backlog = 2500\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Disable packet forwarding\n" >> 01-ipv4.conf
printf "net.ipv4.ip_forward = 0\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Disable redirects, not a router\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.accept_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.accept_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.send_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.send_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.secure_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.secure_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv6.conf.all.accept_redirects = 0\n" >> 01-ipv4.conf
printf "net.ipv6.conf.default.accept_redirects = 0\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Disable source routing\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.accept_source_route = 0\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.accept_source_route = 0\n" >> 01-ipv4.conf
printf "net.ipv6.conf.all.accept_source_route = 0\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Enable source validation by reversed path\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.rp_filter = 1\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.rp_filter = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Log packets with impossible addresses to kernel log\n" >> 01-ipv4.conf
printf "net.ipv4.conf.all.log_martians = 1\n" >> 01-ipv4.conf
printf "net.ipv4.conf.default.log_martians = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Disable ICMP broadcasts\n" >> 01-ipv4.conf
printf "net.ipv4.icmp_echo_ignore_broadcasts = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Ignore bogus ICMP errors\n" >> 01-ipv4.conf
printf "net.ipv4.icmp_ignore_bogus_error_responses = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Against SYN flood attacks\n" >> 01-ipv4.conf
printf "net.ipv4.tcp_syncookies = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# Turning off timestamps could improve security but degrade performance.\n" >> 01-ipv4.conf
printf "# TCP timestamps are used to improve performance as well as protect against\n" >> 01-ipv4.conf
printf "# late packets messing up your data flow. A side effect of this feature is\n" >> 01-ipv4.conf
printf "# that the uptime of the host can sometimes be computed.\n" >> 01-ipv4.conf
printf "# If you disable TCP timestamps, you should expect worse performance\n" >> 01-ipv4.conf
printf "# and less reliable connections.\n" >> 01-ipv4.conf
printf "net.ipv4.tcp_timestamps = 1\n" >> 01-ipv4.conf
printf "\n" >> 01-ipv4.conf
printf "# tcp tune\n" >> 01-ipv4.conf
printf "net.ipv4.tcp_rmem = 4096 87380 16777216\n" >> 01-ipv4.conf
printf "net.ipv4.tcp_wmem = 4096 65536 16777216\n" >> 01-ipv4.conf
printf "net.ipv4.tcp_max_syn_backlog = 4096\n" >> 01-ipv4.conf
printf "net.ipv6.conf.lo.disable_ipv6 = 1\n" >> 02-ipv6.conf
printf "net.ipv6.conf.all.disable_ipv6 = 1\n" >> 02-ipv6.conf
printf "net.ipv6.conf.default.disable_ipv6 = 1\n" >> 02-ipv6.conf
printf "net.ipv6.conf.all.accept_ra = 0\n" >> 02-ipv6.conf
printf "net.ipv6.conf.default.accept_ra = 0\n" >> 02-ipv6.conf
printf "kernel.randomize_va_space = 2\n" > 03-kernel.conf
printf "kernel.dmesg_restrict = 1\n" >> 03-kernel.conf
printf "kernel.sysrq = 0\n" >> 03-kernel.conf
printf "kernel.exec-shield = 1\n" >> 03-kernel.conf
printf "kernel.kptr_restrict = 2\n" >> 03-kernel.conf
printf "fs.inotify.max_user_instances = 8192\n" > 04-fs.conf
printf "fs.suid_dumpable = 0\n >> 04-fs.conf
printf "vm.min_free_kbytes = 65536\n" > 05-vm.conf
printf "printf "vm.swappiness = 0\n" >> 05-vm.conf
printf "vm.overcommit_memory = 1\n" >> 05-vm.conf

#
# 3.2 TCP Wrappers
#
printf "icmp: 192.168.10.0/26\n" > /etc/hosts.allow
printf "icmp: 192.168.20.0/27\n" >> /etc/hosts.allow
printf "sshd: 192.168.10.0/26\n" >> /etc/hosts.allow
printf "ALL: ALL\n" > /etc/hosts.deny


#
# put sudoers in
#
echo "%sudoers    ALL=(ALL:ALL)   NOPASSWD: ALL" > /etc/sudoers.d/sudoers

#
# remove default "sysadm" group
#
/sbin/usermod -g users -G sshusers,sudoers sysadm
/sbin/groupdel sysadm

#
# import epel/puppet keys
#
/bin/rpmkeys --import http://ftp.cse.buffalo.edu/pub/epel/RPM-GPG-KEY-EPEL-7

#
# maybe we can yum update?
#
/bin/yum -y install epel-release

#
# if the above works then this should too...
#
/bin/yum -y install procenv systemd-networkd systemd-resolved rkhunter clamav clamav-data \
    clamav-filesystem clamav-lib clamav-scanner clamav-scanner-systemd clamav-unofficial-sigs \
    clamav-update pam_yubico yum-updateonboot yum-plugin-show-leaves yum-plugin-remove-with-leaves \
    yum-plugin-ps yum-plugin-keys yum-plugin-upgrade-helper yum-plugin-merge-conf ruby-devel rubygems

#
# puppetize me
#
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet

#
# package install
#
/bin/yum -y install https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

#
# update yum repos...
#
/bin/yum -y update

#
# ... and install puppetserver
/bin/yum -y install puppet

#
# run puppet
#
/bin/puppet agent apply

#
# enable the service
#
/bin/systemctl enable puppet

#
# add audit to grub
#
CURRENT_GRUB_CMDLINE="$(/bin/grep GRUB_CMDLINE_LINUX /etc/default/grub)"
NEW_GRUB_CMDLINE="$(echo ${CURRENT_GRUB_CMDLINE} | /bin/sed -e "s/\"$/ audit=1\"/g")"
/bin/sed -ie "s/${CURRENT_GRUB_CMDLINE}/${NEW_GRUB_CMDLINE}/" /etc/default/grub

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
chmod 640 /etc/syslog.conf /etc/security/access.conf /etc/crontab /etc/sysctl.conf
chmod -R 750 /var/log/audit /usr/share/logwatch/scripts/logwatch.pl /var/crash /etc/skel
chown -R root. /var/crash

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

# End of the %post section
%end
