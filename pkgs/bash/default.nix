{ lib, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = lib.contents ./bashrc;
  };
}
