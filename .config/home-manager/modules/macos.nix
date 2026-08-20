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
      raycast-beta
      ghostty-bin
      orbstack
    ];

    sessionVariables = {
      # The launchd daemon listens on /var/run/netbird.sock, but this netbird's CLI defaults to
      # /var/run/netbird/sock. A --daemon-addr alias cannot bridge that: `netbird ssh` parses its
      # own flag set and rejects the flag outright. The env var is read by every subcommand.
      # Linux does not need this -- there the daemon and CLI already agree on the default.
      NB_DAEMON_ADDR = "unix:///var/run/netbird.sock";
    };
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
