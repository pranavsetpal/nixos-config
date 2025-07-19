{ userInfo, ... }: {
	programs.git = {
		enable = true;
		userName = userInfo.fullname;
		userEmail = userInfo.email;
		signing = {
			key = builtins.getEnv "GPG_SIGNING_KEY";
			signByDefault = true;
		};

	};
}
