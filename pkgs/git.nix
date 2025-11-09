{ userInfo, ... }: {
	programs.git = {
		enable = true;
		settings.user = {
			name = userInfo.fullname;
			email = userInfo.email;
		};
		signing = {
			key = builtins.getEnv "GPG_SIGNING_KEY";
			signByDefault = true;
		};

	};
}
