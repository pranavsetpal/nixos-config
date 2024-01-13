{
  description = "basic nixos install flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zig = {
    #   url = "github:/ziglang/zig";
    #   flake = false;
    # };
  };

  # outputs = { self, nixpkgs, home-manager, zig } @ inputs: 
  outputs = { self, nixpkgs, home-manager } @ inputs: 
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
          ./nixos-config.nix

          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit userInfo; };
              users."${userInfo.name}".imports = [ ./hm-config.nix ];
            };
          }
        ];
      };
    };
}
