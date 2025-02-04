{
	description = "nixos setup flake";

	inputs = {
		nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixos-unstable";
		};

		zig.url = "github:mitchellh/zig-overlay";
		qtile.url = "github:qtile/qtile";
	};

	outputs = { self, nixos-unstable, home-manager, zig, qtile, ... }: let
		sysInfo = {
			system = "x86_64-linux";
			hostname = "laptop";
		};

		userInfo = rec {
			name = "pranav";
			fullname = "pranavsetpal";
			email = "pranav.setpal@gmail.com";
			homedir = "/home/${name}";
		};

		pkgs = import nixos-unstable { system = sysInfo.system; };

		flake-overlays = [ zig.overlays.default qtile.overlays.default ];
	in {
		nixosConfigurations.${sysInfo.hostname} = nixos-unstable.lib.nixosSystem {
			system = sysInfo.system;
			specialArgs = { inherit sysInfo userInfo; };
			modules = [ ./hardware-configuration/asus-ux8402vu.nix ./configuration.nix ];
		};

		homeConfigurations.${userInfo.name} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = { inherit userInfo flake-overlays; };
			modules = [ ./home.nix ];
		};
	};
}
