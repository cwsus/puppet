function FindProxyForURL(url, host)
{
    if ((isPlainHostName(host)) || (shExpMatch(host, "*.caspersbox.com")))
    {
        return "DIRECT";
    }
    else if ((dnsDomainIs(host, "vpn.mtb.com")) || (dnsDomainIs(host, "vpn-prkcl.mtb.com")) || (dnsDomainIs(host, "vpn-mills.mtb.com")))
    {
        return "DIRECT";
    }
    else if ((dnsDomainIs(host, "access.mtb.com")) || (dnsDomainIs(host, "access-epa.mtb.com")))
    {
        return "DIRECT";
    }

    return "PROXY proxy.caspersbox.com:3128";
}
