if [[ $1 = "sources" ]]; then
		nix flake update

elif [[ $1 = "os" ]]; then
		nixos-rebuild build --flake .#laptop
		nvd diff /run/current-system ./result

		read -p ":: Proceed with installation? [Y/n]: " confirm
		if [[ "$confirm" == "" || "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]]; then
				doas nixos-rebuild switch --flake .#laptop
		else
				echo ":: Installation Cancelled"
				exit 2
		fi

		rm -rf ./result

elif [[ $1 = "home" ]]; then
		home-manager build --flake .
		nvd diff ../.nix-profile ./result

		read -p ":: Proceed with installation? [Y/n]: " confirm
		if [[ "$confirm" == "" || "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]]; then
				home-manager switch --flake .
		else
				echo ":: Installation Cancelled"
		fi

		rm -rf ./result

elif [[ $# == 0 || $1 == "all" ]]; then
		nixos-update sources
		nixos-update os
		nixos-update home

else
		echo "Unknown option: choose sources/os/home/all or leave blank for all"
fi
