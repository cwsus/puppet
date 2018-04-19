#
# named accounting
#
class named::accounting($groupname, $username)
{
    group { "add-group-${groupname}":
        ensure              => present,
        name                => "${groupname}",
        gid                 => ${groupid},
        members             => "${username}",
        provider            => "groupadd",
    }

    user { 'add-user-${username}':
        ensure              => present,
        name                => "$username",
        groups              => "$groupname",
        home                => "/home/$username",
        managehome          => true,
        password            => '$1$TFcMWR5P$I6Pr6Q4kRuNz0yRS8qSqL.',
        provider            => "useradd",
        shell               => "/sbin/nologin",
        system              => false,
        uid                 => $userid,
    }
}
