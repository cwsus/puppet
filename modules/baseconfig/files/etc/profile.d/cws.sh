#<%# /etc/puppetlabs/puppet/modules/motd/templates/motd.erb %>
#==============================================================================
#
#          FILE:  /etc/profile.d/cws.sh
#         USAGE:  . /etc/profile.d/cws.sh
#   DESCRIPTION:  Sets application-wide functions
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Kevin Huntly <kmhuntly@gmail.com>
#       COMPANY:  ---
#       VERSION:  1.0
#       CREATED:  ---
#      REVISION:  ---
#
#==============================================================================

typeset _TRUE="true";
typeset _FALSE="false";
typeset ENABLE_VERSBOSE="${_FALSE}";
typeset ENABLE_DEBUG="${_FALSE}";
typeset ENABLE_TRACE="${_FALSE}";
#typeset -ri TMOUT=900;
typeset -r HISTFILE;
#typeset -r http_proxy="http://proxy.caspersbox.com:8080/"
#typeset -r https_proxy="http://proxy.caspersbox.com:8080/"
#typeset -r ftp_proxy="http://proxy.caspersbox.com:8080/"

[ ! -z "${ENABLE_VERBOSE}" ] && [ "${ENABLE_VERBOSE}" = "${_TRUE}" ] && set -x || set +x;
[ ! -z "${ENABLE_TRACE}" ] && [ "${ENABLE_TRACE}" = "${_TRUE}" ] && set -v || set +v;

typeset -x PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin";

## user information
typeset -i USER_DISK_USAGE=$(/usr/bin/env du -ms ${HOME}/ 2>/dev/null | /usr/bin/env awk '{print $1}');
typeset -i SYSTEM_PROCESS_COUNT=$(/usr/bin/env ps -ef | /usr/bin/env wc -l | awk '{print $1}');
typeset -i USER_PROCESS_COUNT=$(/usr/bin/env ps -ef | /usr/bin/env grep "${LOGNAME}" | /usr/bin/env wc -l);

[ ! -z "${ENABLE_DEBUG}" ] && [ "${ENABLE_DEBUG}" = "true" ] && writeLogEntry "DEBUG" "${METHOD_NAME}" "${0}" "${LINENO}" "USER_DISK_USAGE -> ${USER_DISK_USAGE}";
[ ! -z "${ENABLE_DEBUG}" ] && [ "${ENABLE_DEBUG}" = "true" ] && writeLogEntry "DEBUG" "${METHOD_NAME}" "${0}" "${LINENO}" "SYSTEM_PROCESS_COUNT -> ${SYSTEM_PROCESS_COUNT}";
[ ! -z "${ENABLE_DEBUG}" ] && [ "${ENABLE_DEBUG}" = "true" ] && writeLogEntry "DEBUG" "${METHOD_NAME}" "${0}" "${LINENO}" "USER_PROCESS_COUNT -> ${USER_PROCESS_COUNT}";

echo "
+-------------------------------------------------------------------+
Welcome to $(hostname)
+-------------------------------------------------------------------+
+---------------------- System Information -------------------------+
+ IP Address     : $(/usr/bin/env ip addr | /usr/bin/env grep inet | /usr/bin/env grep -v "127.0.0.1" | /usr/bin/env head -1 | /usr/bin/env awk '{print $2}')
+ OS             : $(/usr/bin/env cat /etc/redhat-release | awk '{print $1 " " $2}') / $(/usr/bin/env cat /etc/redhat-release | awk '{print $4}')
+ Kernel version : $(/usr/bin/env uname -r) / $(/usr/bin/env uname -v)
+ CPU            : $(/usr/bin/env cat /proc/cpuinfo | /usr/bin/env grep processor | /usr/bin/env wc -l) / $(/usr/bin/env cat /proc/cpuinfo | /usr/bin/env grep "model name" | /usr/bin/env head -1 | /usr/bin/env awk -F ":" '{print $2}' | /usr/bin/env sed -e "s/^ //g")
+ Memory         : $(/usr/bin/env echo "scale=2; $(/usr/bin/env free | /usr/bin/env grep Mem | /usr/bin/env awk '{print $2}') / 1024 / 1024" | /usr/bin/env bc) MB
+-------------------------------------------------------------------+

This is a server owned and operated by CaspersBox Web Services.

WARNING: YOU MUST HAVE PRIOR AUTHORIZATION TO ACCESS THIS SYSTEM.
ALL CONNECTIONS ARE LOGGED AND MONITORED. BY CONNECTING TO THIS
SYSTEM YOU FULLY CONSENT TO ALL MONITORING. UNAUTHORIZED ACCESS
OR USE WILL BE PROSECUTED TO THE FULL EXTENT OF LAW.

+----------------------- User Information --------------------------+
+ Username     : ${LOGNAME}
+ Disk Usage   : You're currently using ${USER_DISK_USAGE} MB in ${HOME}
+ Processes    : ${SYSTEM_PROCESS_COUNT} of which ${USER_PROCESS_COUNT} are yours
+-------------------------------------------------------------------+
";

[ ! -z "${USER_DISK_USAGE}" ] && unset -v USER_DISK_USAGE;
[ ! -z "${SYSTEM_PROCESS_COUNT}" ] && unset -v SYSTEM_PROCESS_COUNT;
[ ! -z "${USER_PROCESS_COUNT}" ] && unset -v USER_PROCESS_COUNT;

[ ! -z "${ENABLE_VERBOSE}" ] && [ "${ENABLE_VERBOSE}" = "true" ] && set +x;
[ ! -z "${ENABLE_TRACE}" ] && [ "${ENABLE_TRACE}" = "true" ] && set +v;
