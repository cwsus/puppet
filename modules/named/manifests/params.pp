class named::params (
) {
    $groupname = lookup({"name" => "profile::named::groupname", value_type => String, default_value => "named"}),
    $groupid = lookup({"name" => "profile::named::groupid", value_type => Integer, default_value => 5001}),
    $username = lookup({"name" => "profile::named::username", value_type => String, default_value => "named"}),
    $userid = lookup({"name" => "profile::named::userid", value_type => Integer, default_value => 5001}),
    $ismaster = lookup("profile::named::ismaster", {value_type => Boolean, default_value => false}),
    $masterserver = lookup("profile::named::masterserver", {value_type => String, default_value => ""}),
    $servers = lookup("profile::named::servers", {value_type => Hash, default_value => ""})
}
