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

      pkgs = import nixos-unstable { inherit system; };
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
        specialArgs = { inherit pkgs stable userInfo; };
        modules = [ ./device/portable.nix ./nixos-config.nix ];
      };

      homeConfigurations.${userInfo.name} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit stable userInfo zig-overlay; };
        modules = [ ./hm-config.nix ];
      };
    };
}

