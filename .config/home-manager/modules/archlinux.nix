{
  pkgs,
  user,
  zen-browser,
  ...
}:
{
  home = {
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # Kubernetes and CloudNative related.
      podman
      podman-compose
      podman-tui

      # Desktop apps.
      ghostty
      zen-browser.packages.x86_64-linux.specific
    ];

    shellAliases = {
      docker = "podman";
      docker-compose = "podman-compose";
      compose = "podman-compose";
    };
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-tty;

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/home/${user}/.ssh/github";
    };
  };
}
