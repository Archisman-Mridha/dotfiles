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
      kubectl
      podman
      podman-compose
      podman-tui

      # Wayland Compositor related.
      xdg-desktop-portal-hyprland
      hyprland
      waybar
      rofi
      hyprpaper
      hyprcursor
      hyprlock
      hypridle
      waypipe

      # Desktop apps.
      zen-browser.packages.x86_64-linux.specific
      mattermost-desktop

      dysk
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
