{
  pkgs,
  user,
  zen-browser,
  ...
}:
{
  home = {
    homeDirectory = "/home/${user}";

    sessionVariables = {
      GI_TYPELIB_PATH = "/usr/lib/girepository-1.0/";
    };

    packages = with pkgs; [
      # TODO : This isn't working. Shift to WireGuard.
      # protonvpn-cli

      # Wayland Compositor
      xdg-desktop-portal-hyprland
      hyprland
      waybar
      rofi
      hyprpaper
      hyprcursor
      hyprlock
      hypridle
      waypipe

      # Desktop Apps
      zen-browser.packages.x86_64-linux.specific
      mattermost-desktop
    ];
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-tty;

  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = "/home/${user}/.ssh/github";
    };
  };
}
