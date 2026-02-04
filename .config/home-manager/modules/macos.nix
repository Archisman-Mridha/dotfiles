{ user, pkgs, ... }:
{
  home = {
    homeDirectory = "/Users/${user}";

    shellAliases = {
      code = "~/Applications/Home\\ Manager\\ Apps/Visual\\ Studio\\ Code.app/Contents/MacOS/Electron";
    };

    packages = with pkgs; [
      # Desktop apps.
      orbstack
    ];
  };

  services = {
    gpg-agent.pinentry.package = pkgs.pinentry_mac;

    # ollama.enable = true;
  };

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/Users/${user}/.ssh/github";
    };
  };
}
