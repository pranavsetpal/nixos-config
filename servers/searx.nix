{ ... }: {
	services.searx = {
		enable = true;
		settings.server.secret_key = "";
	};
}
