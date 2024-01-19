{
  description = "nixos setup flake";

  inputs = {
    nixos-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    zig-overlay.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixos-stable, nixos-unstable, home-manager, zig-overlay, ... }:
    let
      system = "x86_64-linux";

      # pkgs = import nixos-unstable { inherit system; };
      stable = import nixos-stable { inherit system; };

      userInfo = rec {
        name = "pranav";
        fullname = "pranavsetpal";
        email = "pranav.setpal@gmail.com";
        homedir = "/home/${name}";
      };
    in {
      nixosConfigurations.portable = nixos-unstable.lib.nixosSystem {
        system = system;
        specialArgs = { inherit stable userInfo; };
        modules = [
          ./device/portable.nix
          ./nixos-config.nix

          home-manager.nixosModules.home-manager { home-manager = {
            useGlobalPkgs = false;
            useUserPackages = true;
            extraSpecialArgs = { inherit stable userInfo zig-overlay; };
            users.${userInfo.name} = import ./hm-config.nix;
          }; }
        ];
      };
    };
}
