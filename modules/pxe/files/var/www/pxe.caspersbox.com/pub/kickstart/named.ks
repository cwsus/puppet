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
group --name dnsgrp   --gid=5002

#
# Create sysadm user
#
user --uid=5000 --groups=wheel,sudoers,sshusers --name=sysadm --password=$6$y3ThUPaNQ/Gjx0hQ$YC7ffb3kTAPMGGK4mE0sLuhFMfrKtWCu9dczT.PuvdCJ.Y830nggxNdhxg02.jLZGLK4h6HZ1sWXAri.l5q2O.  --iscrypted
user --uid=5002 --groups=dnsgrp                 --name=dnsadm --password=$6$5e23zVh5jtzKtxbL$AC7v3IFC4QpmgMd27xHicQ.P692SDl/lMUFIBg.ZdVnFXQg/t3wJu/zx2q8jcw6bcYtewbc2KRux5PTID4gGe0 --iscrypted
user --uid=5003 --groups=dnsgrp                 --name=dnssrv --password=$6$cMtwmyXmdI5bn3a1$217Q1rvQCjRWyG7K79NrPRn2hzriToBEMTNkcSkKNiniKbDuC6hqRuZQakGwY3AVEUEflrbbYNFieDxUjwbnE  --iscrypted

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
logvol /tmp           --fstype="ext4"  --size=512  --vgname=centos --name=lv_tmp       --label=lv_tmp       --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var           --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var       --label=lv_var       --mkfsoptions="-m 1" --fsoptions="rw,nosuid"
logvol /var/cache     --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-cache --label=lv_var-cache --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/log       --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-log   --label=lv_var-log   --mkfsoptions="-m 0" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/log/audit --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-audit --label=lv_var-audit --mkfsoptions="-m 0" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/tmp       --fstype="ext4"  --size=1024 --vgname=centos --name=lv_var-tmp   --label=lv_var-tmp   --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
logvol /var/named     --fstype="ext4"  --size=256  --vgname=centos --name=lv_var-named --label=lv_var-named --mkfsoptions="-m 1" --fsoptions="rw,nodev,noexec,nosuid"
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
bind-chroot
bind-utils
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
# nameservers - i think we need them
#
echo "nameserver 192.168.20.6" > /etc/resolv.conf
echo "nameserver 192.168.20.7" >> /etc/resolv.conf

#
# add entries to fstab
#
echo "/dev/cdrom    /mnt/cdrom    iso9660 ro,noexec,nosuid,nodev,noauto    0 0" >> /etc/fstab
echo "/tmp          /var/tmp      none    rw,nodev,noexec,nosuid,bind      0 0" >> /etc/fstab
echo "tmpfs         /dev/shm      tmpfs   rw,nodev,noexec,nosuid           0 0" >> /etc/fstab
echo "proc          /proc         proc    rw,hidepid=2                     0 0" >> /etc/fstab

#
# systemctl
#
/bin/systemctl mask ctrl-alt-del
/bin/systemctl set-default multi-user.target
/bin/systemctl enable psacct
/bin/systemctl enable chronyd
/bin/systemctl enable sysstat
/bin/systemctl enable auditd
/bin/systemctl enable named-chroot
/bin/systemctl disable kdump
/bin/systemctl disable tuned
/bin/systemctl mask kdump
/bin/systemctl mask tuned
/bin/systemctl mask named

#
# put sudoers in
#
echo "%sudoers    ALL=(ALL:ALL)   NOPASSWD: ALL" > /etc/sudoers.d/sudoers

#
# remove default "sysadm" group
#
/sbin/usermod -g users -G sshusers,sudoers sysadm
/sbin/usermod -g dnsgrp -G sudoers dnsadm
/sbin/usermod -g dnsgrp -s /sbin/nologin dnssrv
/sbin/groupdel sysadm
/sbin/groupdel dnsadm
/sbin/groupdel dnssrv

#
# import epel key
#
/bin/rpmkeys --import http://ftp.cse.buffalo.edu/pub/epel/RPM-GPG-KEY-EPEL-7

#
# maybe we can yum update?
#
/bin/yum -y install epel-release
/bin/yum -y update

#
# if the above works then this should too...
#
/bin/yum -y install procenv systemd-networkd systemd-resolved rkhunter clamav clamav-data \
    clamav-filesystem clamav-lib clamav-scanner clamav-scanner-systemd clamav-unofficial-sigs \
    clamav-update pam_yubico yum-updateonboot yum-plugin-show-leaves yum-plugin-remove-with-leaves \
    yum-plugin-ps yum-plugin-keys yum-plugin-upgrade-helper yum-plugin-merge-conf

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

%post --nochroot --log=/root/ks-post-nochroot.log

#
# prelinking
#
/bin/sed -i "s/PRELINKING=.*/PRELINKING=no/g" /etc/sysconfig/prelink
/sbin/prelink -ua

%end
