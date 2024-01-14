{
  description = "nixos setup flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig-overlay.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, home-manager, zig-overlay }:
    let
      userInfo = rec {
        name = "pranav";
        fullname = "pranavsetpal";
        email = "pranav.setpal@gmail.com";
        homedir = "/home/${name}";
      };
    in {
      nixosConfigurations.portable = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit userInfo; };
        modules = [
          ./device/portable.nix
          ./nixos-config.nix

          home-manager.nixosModules.home-manager { home-manager = {
            useGlobalPkgs = false;
            useUserPackages = true;
            extraSpecialArgs = { inherit userInfo zig-overlay; };
            users.${userInfo.name}.imports = [ ./hm-config.nix ];
          }; }
        ];
      };
    };
}
