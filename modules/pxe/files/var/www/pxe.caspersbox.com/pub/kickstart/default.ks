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
# generate password with echo 'import crypt,getpass; print crypt.crypt(getpass.getpass(), "$1$<SALT>")' | python -
# replace <SALT> with an 8 char salt
#
user --uid=5000 --groups=wheel,sshusers,sudoers --name=sysadm --password=$1$3wYrtggq$v4Qwv4BGcB6aEumrTgLX6/ --iscrypted

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
network --device=bootif --bootproto=dhcp --ethtool="autoneg on lro off" --mtu=1500 --noipv6 --activate --onboot=yes --hostname=localhost.localdomain

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
# root password
# generate password with echo 'import crypt,getpass; print crypt.crypt(getpass.getpass(), "$1$<SALT>")' | python -
# replace <SALT> with an 8 char salt
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
# generate password with grub2-mkpasswd-pbkdf2
#
bootloader --location=mbr --boot-drive=sda --timeout=3 --append="nopti noibrs noibpb" --iscrypted --password=<password>
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
openssl
openssl-devel
gcc-c++
make
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
# get our baseconfig here
#
/bin/wget -O /var/tmp/baseconfig.tar.gz http://pxe.caspersbox.com/priv/baseconfig.tar.gz
/bin/wget -O /var/tmp/baseconfig.tar.gz http://pxe.caspersbox.com/priv/duo_unix-latest.tar.gz
/bin/wget -O /var/tmp/sshd_config http://pxe.caspersbox.com/priv/etc/ssh/sshd_config
/bin/wget -O /var/tmp/network http://pxe.caspersbox.com/priv/etc/sysconfig/network

#
# place it
#
cd /
/bin/gunzip /var/tmp/baseconfig.tar.gz
/bin/tar -xf /var/tmp/baseconfig.tar
/bin/mv /var/tmp/sshd_config /etc/ssh/sshd_config
/bin/mv /var/tmp/network /etc/sysconfig/network

#
# install duo
#
cd /var/tmp
/bin/gunzip /var/tmp/duo_unix-latest.tar.gz
/bin/tar -xf /var/tmp/duo_unix-latest.tar
cd /var/tmp/duo_unix-1.10.1
/var/tmp/duo_unix-1.10.1/configure --with-pam --prefix=/usr
/bin/make
/bin/make install

#
# cleanup
#
/bin/rm -rf /var/tmp/duo_unix-1.10.1
/bin/rm -f /var/tmp/baseconfig.tar.gz
/bin/rm -f /etc/baseconfig.tar
/bin/rm -f /var/tmp/duo_unix-latest.tar
/bin/rm -f /var/tmp/duo_unix-latest.tar.gz
/bin/rm -f /var/tmp/sshd_config
/bin/rm -f /var/tmp/network

#
# services
#
/bin/systemctl enable aide.timer
/bin/systemctl enable freshclam.timer
/bin/systemctl enable puppet-agent.timer
/bin/systemctl enable rkhunter-update.timer
/bin/systemctl enable sshd.service
/bin/systemctl enable yum-daily-update.timer
/bin/systemctl enable yum-weekly-update.timer

#
# disable usb support and add audit
#
CURRENT_GRUB_CMDLINE="$(/bin/grep GRUB_CMDLINE_LINUX /etc/default/grub)"
NEW_GRUB_CMDLINE="$(echo ${CURRENT_GRUB_CMDLINE} | /bin/sed -e "s/\"$/ nousb audit=1\"/g")"
/bin/sed -ie "s/${CURRENT_GRUB_CMDLINE}/${NEW_GRUB_CMDLINE}/" /etc/default/grub

/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg

#
# remove default "sysadm" group
#
/sbin/usermod -g users -G sshusers,sudoers sysadm
/sbin/groupdel sysadm

#
# import epel/puppet keys
#
/bin/rpmkeys --import http://ftp.cse.buffalo.edu/pub/epel/RPM-GPG-KEY-EPEL-7
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
/bin/rpmkeys --import http://yum.puppetlabs.com/RPM-GPG-KEY-puppet

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
    clamav-update pam_yubico yum-updateonboot yum-plugin-show-leaves yum-plugin-remove-with-leaves \
    yum-plugin-ps yum-plugin-keys yum-plugin-upgrade-helper yum-plugin-merge-conf puppet google-authenticator

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
