{ pkgs, ... }: {
	services.printing = {
		enable = true;
		drivers = with pkgs; [ epson-201401w ];
	};
}
