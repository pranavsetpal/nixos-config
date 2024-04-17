{ lib, pkgs, userInfo, ... }: {
  programs = {
    bash = {
      enable = true;
      bashrcExtra = /* bash */ ''
        export PS1="[\u@\H \W]\$ "

        bind '"\e[A":history-search-backward'
        bind '"\e[B":history-search-forward'

        nixos-update() { (
            cd ${userInfo.homedir}/.nixos &&
            ${lib.fileContents ./nixos-update.sh}
        ) }
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;

      config = {
        global.hide_env_diff = true;
      };
    };
  };

  home.packages = with pkgs; [ nvd ];
}

