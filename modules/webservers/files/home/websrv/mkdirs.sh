#!/usr/bin/env bash

[ -d /var/run/httpd ] && /usr/bin/env sudo -u root mkdir -pv /var/run/httpd;
[ -d /var/lock/httpd ] && /usr/bin/env sudo -u root mkdir -pv /var/lock/httpd;
[ -d /var/cache/httpd ] && /usr/bin/env sudo -u root mkdir -pv /var/cache/httpd;

for SITE in $(/bin/ls -ltr /etc/httpd/conf.d | /bin/grep ^d | /bin/awk '{print $NF}')
do
    [ ! -d /var/www/${SITE}/html ] && /usr/bin/env sudo -u root mkdir -pv /var/www/${SITE}/html;
    [ ! -d /var/log/httpd/${SITE} ] && /usr/bin/env sudo -u root mkdir /var/log/httpd/${SITE};
    [ ! -d /var/run/httpd/${SITE} ] && /usr/bin/env sudo -u root /bin/mkdir -pv /var/run/httpd/${SITE};

    [ ! -z "${SITE}" ] && unset -v SITE;
done

for DIR in /var/www /var/run/httpd /var/lock/httpd /var/cache/httpd /var/log/httpd
do
    /usr/bin/env sudo -u root /bin/chown -Rh websrv. ${DIR};

    [ ! -z "${DIR}" ] && unset -v DIR;
done

exit 0
