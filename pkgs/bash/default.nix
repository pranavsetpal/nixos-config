{ lib, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = lib.fileContents ./bashrc;
  };
}
