{ ... }: {
  networking = {
    hostName = "portable";
    wireless.iwd = {
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
        Network.NameResolvingService= "resolvconf";
      };
    };
    resolvconf = {
      enable = true;
      useLocalResolver = true;
    };
  };
}
