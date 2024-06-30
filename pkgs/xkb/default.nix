{ pkgs, ... }: {
	home = {
		packages = with pkgs; [ libxkbcommon ];
		file.".config/xkb" = {
			source = ./xkb;
			recursive = true;
		};
	};

}
