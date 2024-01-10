{ userInfo, ... }: {
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ userInfo.name ];
      persist = true;
      keepEnv = true;
    }];
  };
}
