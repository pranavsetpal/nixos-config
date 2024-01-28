{ lib, userInfo, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = /* bash */ ''
      export PS1="[\u@\H \W]\$ "

      bind '"\e[A":history-search-backward'
      bind '"\e[B":history-search-forward'

      nixos-update() {
          if [[ $1 = "sources" ]]; then
              doas nix flake update ${userInfo.homedir}/.nixos/

          elif [[ $1 = "os" ]]; then
              doas nixos-rebuild switch --flake ${userInfo.homedir}/.nixos/#portable

          elif [[ $1 = "home" ]]; then
              home-manager switch --flake ${userInfo.homedir}/.nixos/

          elif [[ $# == 0 || $1 == "all" ]]; then
              doas nix flake update ${userInfo.homedir}/.nixos/
              doas nixos-rebuild switch --flake ${userInfo.homedir}/.nixos/#portable
              home-manager switch --flake ${userInfo.homedir}/.nixos/

          else
              echo "Unknown option: choose sources/os/home/all or leave blank for all"
          fi
      }
    '';
  };
}

