{ userInfo, ... }: {
  networking = {
    hostName = "portable";

    wireless.iwd.enable = true;

  };

  services.unbound = {
    enable = true;
    user = userInfo.name;
    settings = {
      server.interface = [ "127.0.0.1" ];
      do-ip6 = "yes";
      prefer-ip6 = "yes";
      harden-dnssec-stripped = "yes";
    };
  };

  services.dnsmasq = {
    enable = true;
    settings.listen-address = "::1,127.0.0.1";
  };
}
