{ user, pkgs, ... }:
{
  home = {
    homeDirectory = "/Users/${user}";

    packages = with pkgs; [
      mkalias
      terminal-notifier
      pinentry_mac

      # Desktop apps.
      betterdisplay
      raycast
      ghostty-bin
      orbstack
    ];

    sessionVariables = { };
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
