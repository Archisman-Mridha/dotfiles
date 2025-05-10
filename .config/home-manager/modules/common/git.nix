{
  programs.git = {
    enable = true;

    extraConfig = {
      commit.gpgsign = true;

      includeIf = {
        "gitdir:~/Documents/obmondo/" = {
          path = "~/Documents/obmondo/obmondo.gitconfig";
        };

        "gitdir:~/" = {
          path = "~/personal.gitconfig";
        };
      };

      push.autoSetupRemote = true;
    };

    delta = {
      enable = true;
      options = {
        navigate = true;
        dark = true;
      };
    };
  };
}
