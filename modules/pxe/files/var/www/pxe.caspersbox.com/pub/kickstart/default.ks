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
vnc --password AZtJCJWd
install
cdrom

#
# Run the Setup Agent on first boot
#
firstboot --disable

#
# standard groups
#
group --name=sudoers  --gid=5000
group --name=sshusers --gid=6000

#
# Create sysadm user
# generate password with echo 'import crypt,getpass; print crypt.crypt(getpass.getpass(), "$6$0iPmPXaknOpgo8yL")' | python -
#
user --uid=5001 --groups=wheel,sshusers,sudoers --name=sysadm --password=$6$0iPmPXaknOpgo8yL$PJB13TijD92fUCeVY9Be/itN47Xp2AM5e46LatwjxxXgEp5GhPy58gPnDnciJNwvSQTEIPQ4abdTMQKyWULaS0 --iscrypted

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
network --device=link --bootproto=dhcp --ethtool="autoneg on gro off lro off" --mtu=1500 --noipv6 --activate --onboot=yes --hostname=localhost.localdomain

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
# generate password with echo 'import crypt,getpass; print crypt.crypt(getpass.getpass(), "$6$<16 CHAR SALT>")' | python -
#
rootpw --iscrypted $6$0iPmPXaknOpgo8yL$PJB13TijD92fUCeVY9Be/itN47Xp2AM5e46LatwjxxXgEp5GhPy58gPnDnciJNwvSQTEIPQ4abdTMQKyWULaS0

#
# System timezone
#
timezone --isUtc America/New_York --ntpservers=192.168.10.1

#
# disk
#
ignoredisk --only-use=sda

#
# System bootloader configuration
# generate password with grub2-mkpasswd-pbkdf2
#
bootloader --location=mbr --boot-drive=sda --timeout=3 --append="nopti noibrs noibpb" --iscrypted --password=grub.pbkdf2.sha512.10000.33C6ED219C99C970B28B7848269684DD4D7E63651100E7C836E70A41D2872EEB8677BE832505F077EB7B978E435E891BC7341BD8989CBFFF9D464EDFBCEB6DBE.560B9DB48A01728C0A6D4E5CFDBBA3F15D5F45A407CA0DDB3040873E1C144B1835A1845CD8DC768EB6DD8A4EB1A375B94BF0AC6C603873F77A113C0C291BE7DA
zerombr

#
# Partition clearing information
#
clearpart --all --initlabel

#
# boot partition
#
part /boot --fstype="ext2" --ondisk=sda --size=512 --label=boot --mkfsoptions="-m 0" --fsoptions="rw,nosuid,nodev,noexec"

#
# 15GB physical volume on /dev/sda
#
part pv.01 --fstype="lvmpv" --ondisk=sda --size=14077
volgroup centos --pesize=4096 pv.01

#
# logical volumes
#
logvol /              --fstype="ext4" --size=4096 --vgname=centos --name=lv_root      --label=lv_root      --mkfsoptions="-m 1"
logvol /home          --fstype="ext4" --size=512  --vgname=centos --name=lv_home      --label=lv_home      --mkfsoptions="-m 0" --fsoptions="rw,nosuid,nodev"
logvol /opt/cws       --fstype="ext4" --size=1024 --vgname=centos --name=lv_opt-cws   --label=lv_opt-cws   --mkfsoptions="-m 1" --fsoptions="rw,nosuid,nodev,noexec"
logvol /tmp           --fstype="ext4" --size=1024 --vgname=centos --name=lv_tmp       --label=lv_tmp       --mkfsoptions="-m 1" --fsoptions="rw,nosuid,nodev,noexec"
logvol /var           --fstype="ext4" --size=1024 --vgname=centos --name=lv_var       --label=lv_var       --mkfsoptions="-m 1" --fsoptions="rw,nosuid"
logvol /var/cache     --fstype="ext4" --size=1024 --vgname=centos --name=lv_var-cache --label=lv_var-cache --mkfsoptions="-m 1" --fsoptions="rw,nosuid,nodev,noexec"
logvol /var/log       --fstype="ext4" --size=1024 --vgname=centos --name=lv_var-log   --label=lv_var-log   --mkfsoptions="-m 0" --fsoptions="rw,nosuid,nodev,noexec"
logvol /var/log/audit --fstype="ext4" --size=1024 --vgname=centos --name=lv_var-audit --label=lv_var-audit --mkfsoptions="-m 0" --fsoptions="rw,nosuid,nodev,noexec"
logvol swap           --fstype="swap" --size=3072 --vgname=centos --name=lv_swap      --label=lv_swap                           --fsoptions="swap"

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
pam-devel
gcc-c++
net-tools
policycoreutils-python
checkpolicy
bzip2
pciutils
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
-biosdevname
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

typeset INTERFACE=$(/sbin/ip addr | grep -i broadcast | awk '{print $2}' | /bin/sed -e 's/://g')
typeset HWADDR=$(/sbin/ip addr show dev ${INTERFACE} | /bin/grep ether | /bin/awk '{print $2}')

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

echo "[duosecurity]
name=Duo Security Repository
baseurl=http://pkg.duosecurity.com/CentOS/\$releasever/\$basearch
enabled=1
gpgcheck=1" > /etc/yum.repos.d/duosecurity.repo;

#
# update yum repos...
#
/bin/yum -y update

#
# install epel-release
#
/bin/yum -y install epel-release

#
# if the above works then this should too...
#
/bin/yum -y install procenv systemd-networkd systemd-resolved rkhunter clamav clamav-data \
    clamav-filesystem clamav-lib clamav-scanner clamav-scanner-systemd clamav-unofficial-sigs \
    clamav-update yum-updateonboot yum-plugin-show-leaves yum-plugin-remove-with-leaves duo_unix \
    yum-plugin-ps yum-plugin-keys yum-plugin-upgrade-helper yum-plugin-merge-conf puppet google-authenticator \
    https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm;

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
MACAddress=${HWADDR}

[Link]
MACAddress=${HWADDR}
MTUBytes=1500

[Network]
Description=CWS
DHCP=ipv4" > /etc/systemd/network/${INTERFACE}.network

echo "HOSTNAME=${INSTALL_HOSTNAME}
NETWORKING=yes
NETWORKING_IPV6=no
IPV6INIT=no
NOZEROCONF=yes" > /etc/sysconfig/networking

#
# udev
#
echo "SUBSYSTEM==\"net\", ATTR{address}==\"${HWADDR}\", NAME==\"${INTERFACE}\", DRIVERS==\"?*\"" > /etc/udev/rules.d/networking_persistent.rules

#
# get our baseconfig here
#
/bin/mkdir -pv /media/cdrom;
/bin/mount /dev/cdrom /media/cdrom;
/bin/cp -Rp /media/cdrom/postinstall/installdata/default/etc/* /etc
/bin/cp -Rp /media/cdrom/postinstall/installdata/default/usr/* /usr

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
/bin/systemctl enable puppet

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
/bin/sed -ie "s^${CURRENT_GRUB_CMDLINE}^${NEW_GRUB_CMDLINE}^" /etc/default/grub

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
# remove unused users
#
for USER in shutdown halt games operator ftp news gopher
do
    /sbin/userdel ${USER};
done

#
# remove unused groups
#
for GROUP in games cdrom dialout floppy tape video audio
do
    /sbin/groupdel ${GROUP};
done

#
# permissions
#
/bin/chmod 600 /etc/duo/login_duo.conf /etc/duo/pam_duo.conf;
/bin/chmod 640 /etc/rsyslog.conf /etc/security/access.conf /etc/crontab /etc/sysctl.conf \
    /etc/sysctl.d/* /etc/yum.conf /etc/freshclam.conf
/bin/chmod -R 750 /var/log/audit /usr/share/logwatch/scripts/logwatch.pl /var/crash /etc/skel \
    /usr/local/bin/*
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

# End of the %post section
%end
