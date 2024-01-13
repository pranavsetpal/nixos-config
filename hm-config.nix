{ pkgs, lib, userInfo, ... }: {
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./pkgs/neovim
    ./pkgs/kitty.nix
    ./pkgs/git.nix
  ];

  home = {
    username = userInfo.name;
    homeDirectory = userInfo.homedir;

    packages = with pkgs; [
      librewolf
      keepassxc
      neofetch
      mpv
      libreoffice-fresh

      pavucontrol

      # Languages
      ccls
      python3
      sage
      zigpkgs.master zls

      # Fonts
      jetbrains-mono
      fira-mono

      # Messaging
      signal-desktop
      element-desktop
      telegram-desktop
    ];

    # To add dotfiles not yet supported by home-manager
    file = {
      # "~/.config/appname".source = dotfiles/appname;
      # "~/.config/appname".source = dotfiles/appname;
    };

    # Setting session variables
    sessionVariables = {
      # env_name = "env_val";
      # env_name = "env_val";
    };
  };
}
