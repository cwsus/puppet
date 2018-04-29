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
url --url http://192.168.10.29:8080/pub/centos/7/os/x86_64

#
# Run the Setup Agent on first boot
#
firstboot --disable

#
# standard groups
#
group --name=sudoers  --gid=5000
group --name=sshusers --gid=5001
group --name=webgrp   --gid=5002
#
# Create sysadm user
#
user --uid=5000 --groups=wheel,sshusers,sudoers --name=sysadm --password=$6$eSnDwhGh5iI0gNDe$Y7r1BIQU0/BBI58IU4MS9fOrC6x1JEr6yIF6mpBm4MCS8TX8Rlpr0L48QJeZ3dpe1XO8rVcVW4FnpRGHJl1HV. --iscrypted
user --uid=5001 --groups=webgrp,sudoers         --name=webadm --password=$6$22FKFzdcQ928crV1$6JHoI38XUk7Yaq8pJMv1rDsVW9W1V3hWyNXelROQ3U1b3bsyP4Ap0BMR9rcA1TKrirEqSvN7Wo.HPci0KtyS70 --iscrypted
user --uid=5002 --groups=webgrp,sudoers         --name=websrv --password=$6$1syGXvDD0OhrLAiQ$y0lpuOXCnFNpz1xh6QAfUUHKtZSjmdQNSO8JGvCgfu6xLFjBLK1clANBzqy0GuGmYTm.Awby4SV17BfSTM8dz/ --iscrypted

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
network --hostname=localhost.localdomain --device=bootif

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
# disk
#
ignoredisk --only-use=sda

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
logvol /var/www       --fstype="ext4"  --size=256  --vgname=centos --name=lv_var-www   --label=lv_var-www   --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol swap           --fstype="swap"  --size=3072 --vgname=centos --name=lv_swap      --label=lv_swap                           --fsoptions="swap"

#
# add extra repos
#
repo --name=CentOS-Extras --mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
repo --name=epel-release --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch --install

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
# we are a webserver, install
#
/bin/yum -y install httpd httpd-tools apr apr-util mod_ssl

#
# get base httpd config here
#

#
# get the postinstall script
#
/bin/wget -O /var/tmp/postinstall.bash http://pxe.caspersbox.com/priv/postinstall.bash

#
# run
#
/bin/bash /var/tmp/postinstall.bash 2>&1 | /bin/tee -a /var/tmp/postinstall.log

%end
