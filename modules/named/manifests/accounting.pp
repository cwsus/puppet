#
# named accounting
#
class named::accounting (
    $groupname = lookup({"name" => "profile::named::groupname", value_type => String, default_value => 'named'}),
    $username = lookup({"name" => "profile::named::username", value_type => String, default_value => 'named'}),
    $groupid = lookup({"name" => "profile::named::groupid", value_type => Integer, default_value => 5005}),
    $userid = lookup({"name" => "profile::named::userid", value_type => Integer, default_value => 5005})
) {
    group { '$groupname':
        ensure              => present,
        name                => '$groupname',
        gid                 => $groupid,
        members             => '$username',
        provider            => 'groupadd',
    }

    user { '$username':
        ensure              => present,
        name                => '$username',
        groups              => '$groupname',
        home                => '/home/$username',
        managehome          => true,
        password            => '$1$TFcMWR5P$I6Pr6Q4kRuNz0yRS8qSqL.',
        provider            => 'useradd',
        shell               => '/sbin/nologin',
        system              => false,
        uid                 => $userid,
    }
}
