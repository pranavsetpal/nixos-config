{ ... }: {
	services.unbound = {
		enable = true;
		settings.remote-control.control-enable = true;
	};
}
