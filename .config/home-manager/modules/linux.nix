{
  pkgs,
  user,
  ...
}:
{
  home = {
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      pinentry-tty

      # Desktop apps.
      ghostty
      vicinae
    ];
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-tty;

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/home/${user}/.ssh/github";
    };
  };
}
