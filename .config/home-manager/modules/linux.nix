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

      # Kubernetes and CloudNative related.
      podman
      podman-compose
      podman-tui

      # Desktop apps.
      ghostty
      vicinae
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
