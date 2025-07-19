{
	description = "nixos setup";

	inputs = {
		nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixos-unstable";
		};
		qtile = {
			url = "github:qtile/qtile";
			inputs.nixpkgs.follows = "nixos-unstable";
		};
		zig = {
			url = "github:mitchellh/zig-overlay";
			inputs.nixpkgs.follows = "nixos-unstable";
		};
		zls = {
			url = "github:zigtools/zls";
			inputs = {
				nixpkgs.follows = "nixos-unstable";
				zig-overlay.follows = "zig";
			};
		};
	};

	outputs = { self, nixos-unstable, home-manager, qtile, zig, zls, ... }: let
		sysInfo = {
			system = "x86_64-linux";
			hostname = "laptop";
		};
		userInfo = rec {
			name = "pranav";
			fullname = "pranavsetpal";
			email = "pranav@setpal.net";
			homedir = "/home/${name}";
		};

		pkgs = import nixos-unstable { system = sysInfo.system; };
		nixos-overlays = [ qtile.overlays.default ];
		home-overlays = [
			zig.overlays.default
			(final: prev: {
				zls = zls.packages.${sysInfo.system}.default;
			})
		];
	in {
		nixosConfigurations.${sysInfo.hostname} = nixos-unstable.lib.nixosSystem {
			system = sysInfo.system;
			specialArgs = { inherit sysInfo userInfo nixos-overlays; };
			modules = [ ./hardware-configuration/asus-ux8402vu.nix ./configuration.nix ];
		};

		homeConfigurations.${userInfo.name} = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			extraSpecialArgs = { inherit userInfo home-overlays; };
			modules = [ ./home.nix ];
		};
	};
}
