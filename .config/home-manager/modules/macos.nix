{ user, pkgs, ... }:
{
  home = {
    homeDirectory = "/Users/${user}";

    packages = with pkgs; [
      # Desktop apps.
      ghostty-bin
      orbstack
    ];
  };

  services = {
    gpg-agent.pinentry.package = pkgs.pinentry_mac;
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/Users/${user}/.ssh/github";
    };
  };
}
