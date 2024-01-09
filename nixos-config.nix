{ config, lib, pkgs, userInfo, ... }: {
  imports = [
    ./system/hardware-config.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
    timeout = 3;
  };

  security.doas = {
    enable = true;
    extraRules = [{
      persist = true;
      keepEnv = true;
    }];
  };
  
  networking.hostName = "portable";
  networking.wireless.iwd.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  # i18n.defaultLocale = "en_IN";
  # i18n.defaultCharacterSet = "UTF-8";
  console.useXkbConfig = true;


  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    libinput.enable = true;

    xkb = {
      layout = "us,us,us";
      variant = "colemak_dh,colemak,";
      options = "grp:alt_space_toggle";
    };

    displayManager.startx.enable = true;
    windowManager.qtile.enable = true;
  };


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # nixpkgs.config.allowUnfree = true;
  # hardware.enableAllFirmware = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${userInfo.name}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # Window Manager
      kitty
      librewolf
      keepassxc
      xclip


      # Neovim
      unixtools.xxd
      # zls
      # clangd

      maim
      bemenu 

      # Audio
      pavucontrol
      jack2

      # Messaging
      signal-desktop
      element-desktop
      telegram-desktop
    ];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    file
    killall
    neovim
    git
    brightnessctl
    neofetch
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = " --delete-older-than 32d ";
    };
  };
}
