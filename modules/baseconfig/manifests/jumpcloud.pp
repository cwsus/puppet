package { 'agent_dependency_curl' :
    ensure => present,
    name   => 'curl'
} ->
package { 'agent_dependency_sudo' :
    ensure => present,
    name   => 'sudo'
} ->
package { 'agent_dependency_bash' :
    ensure => present,
    name   => 'bash'
} ->
exec { 'agent_install' :
    command => "curl --tlsv1.2 --silent --show-error --header 'x-connect-key: 7cda6c28e5463371fbb755fa7e6128d78771f84f' 'https://kickstart.jumpcloud.com/Kickstart' | sudo bash",
    path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin' ],
    timeout => 600,
    creates => '/opt/jc'
}