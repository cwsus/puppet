#
# named user configuration
#
class named::users (
) {
    user { 'named':
        ensure              => present,
        home                => '/var/named',
        shell               => '/sbin/nologin',
        managehome          => true,
        gid                 => 'named',
        password            => '$1$TFcMWR5P$I6Pr6Q4kRuNz0yRS8qSqL.',
    }
}
