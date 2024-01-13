{ userInfo, ... }: {
  programs.git = {
    enable = true;
    userName = userInfo.fullname;
    userEmail = userInfo.email;
  };
}

