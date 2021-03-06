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
url --url http://pxe.caspersbox.com:8080/pub/centos/7/os/x86_64

#
# Run the Setup Agent on first boot
#
firstboot --disable

#
# standard groups
#
group --name=sudoers  --gid=5000
group --name=sshusers --gid=6000
group --name proxygrp --gid=4000

#
# Create sysadm user
#
user --uid=5000 --groups=wheel,sshusers,sudoers --name=sysadm   --password=$6$eSnDwhGh5iI0gNDe$Y7r1BIQU0/BBI58IU4MS9fOrC6x1JEr6yIF6mpBm4MCS8TX8Rlpr0L48QJeZ3dpe1XO8rVcVW4FnpRGHJl1HV. --iscrypted
user --uid=4000 --groups=proxygrp               --name=proxysrv --password=$6$ZH2GlxmxqcOrdkhf$Y0FeKwXNKQH.IkTdMG9r0gTfMT0S07T5sgPo5omdGPUFwVa4fZ/ykX.CofAld4DuqTCOH9CyMY543UxNUoc06/ --iscrypted
user --uid=4001 --groups=proxygrp               --name=proxyadm --password=$6$ZH2GlxmxqcOrdkhf$Y0FeKwXNKQH.IkTdMG9r0gTfMT0S07T5sgPo5omdGPUFwVa4fZ/ykX.CofAld4DuqTCOH9CyMY543UxNUoc06/ --iscrypted

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
rootpw --iscrypted $6$SCVpUMPBkG52XX5s$ryn83AVoADCxeWUdUWGkj0h0IGe0FVoBJVUihEO0RB7Cw7f5myPo90xoCnk8j0NDBwdAJkgZH5ImfvFWpw8S71

#
# System timezone
#
timezone --isUtc America/New_York --ntpservers=caspersb-cs2811.network.caspersbox.com

#
# System bootloader configuration
#
bootloader --location=mbr --boot-drive=sda --timeout=3 --iscrypted --password=grub.pbkdf2.sha512.10000.90A724078888FE744DD0E41A4A31F88160CC6C85E16121DB7632540B2BE393B2948DB34D2DC3B5040EEF08CA46D9164D106C34F94938CABF8851727E52E8DA88.E5DC39A10C445F813CEB7B7575CE40F5D8F12810E8CFA2A6A39B2747DEA16B6950EA3395DA220F3884711006B66AD80FF4497B8E4D66527084E3C3210A590545
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
# 10GB physical volume on /dev/sdb
#
part pv.01 --fstype="lvmpv" --ondisk=sda --size=14077
part pv.02 --fstype="lvmpv" --ondisk=sdb --size=10240
volgroup centos --pesize=4096 pv.01
volgroup squid  --pesize=4096 pv.02

#
# logical volumes
#
logvol /                --fstype="ext4" --size=4096 --label="lv_root"       --name=lv_root      --vgname=centos
logvol /home            --fstype="ext4" --size=100  --label="lv_home"       --name=lv_home      --vgname=centos
logvol /tmp             --fstype="ext4" --size=1024 --label="lv_tmp"        --name=lv_tmp       --vgname=centos
logvol /var             --fstype="ext4" --size=1024 --label="lv_var"        --name=lv_var       --vgname=centos
logvol /var/log         --fstype="ext4" --size=1024 --label="lv_var-log"    --name=lv_var-log   --vgname=centos
logvol /var/log/audit   --fstype="ext4" --size=1020 --label="lv_var-audit"  --name=lv_var-audit --vgname=centos
logvol /var/cache       --fstype="ext4" --size=1024 --label="lv_var-cache"  --name=lv_var-cache --vgname=centos
logvol /var/named       --fstype="ext4" --size=512  --label="lv_var-named"  --name=lv_var-named --vgname=centos
logvol /var/cache/squid --fstype="ext4" --size=8956 --label="lv_var-squid"  --name=lv_var-squid --vgname=squid
logvol swap             --fstype="swap" --size=3072                         --name=lv_swap      --vgname=centos

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
telnet
traceroute
zip
unzip
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
zlib
zlib-devel
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

#
# get the postinstall script
#
/bin/wget -O /var/tmp/postinstall-base.sh http://pxe.caspersbox.com:8080/priv/postinstall-base.sh

#
# run
#
/bin/bash /var/tmp/postinstall-base.sh 2>&1 | /bin/tee -a /var/tmp/postinstall-base.log

#
# we are a proxy, install httpd
#
/bin/yum -y install squid squidGuard

#
# proxy cfg
#
/bin/wget -O /var/tmp/postinstall-proxy.sh http://pxe.caspersbox.com:8080/priv/postinstall-proxy.sh

#
# blacklists
#
cd /var/tmp
/bin/wget -O /var/tmp/shallalist.tar.gz http://www.shallalist.de/Downloads/shallalist.tar.gz
/bin/tar/ xf shallalist.tar.gz
/bin/mv /var/tmp/BL/* /usr/local/squidGuard/db
/bin/chown -Rh proxyadm. /usr/local/squidGuard

# End of the %post section
%end
