{ ... }: {
  networking = {
    hostName = "portable";
    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
      };
    };
  };

  services.unbound = {
    enable = true;
    settings = {
      server = {
        interface = "127.0.0.1";
        port = 53;
        do-udp = "yes";
        do-tcp = "yes";
        do-ip4 = "yes";
        do-ip6 = "yes";
        prefer-ip6 = "yes";

        # harden-glue = "no"; # Send additional data, like ns1.example.com to .com servers
        harden-dnssec-stripped = "yes";
        use-caps-for-id = "no"; # DNSSEC breaks if not set

        prefetch = "yes";
        num-threads = 1;

        edns-buffer-size = 1232; # Recommended for security against large UDP response 
        so-rcvbuf = "1m"; # Ensures kernel buffer is large to not lose messages in traffic spikes

        # Ensures privacy of local IP ranges
        private-address = [
          "192.168.0.0/16"
          "169.254.0.0/16"
          "172.16.0.0/12"
          "10.0.0.0/8"
          "fd00::/8"
          "fe80::/10"
        ];
      };
    };
  };
}

