{
  # Let Determinate Nix handle Nix configuration.
  nix.enable = false;
  determinateNix = {
    enable = true;
    customSettings = {
      # Determinate rewrites /etc/nix/nix.conf on every upgrade, so trusted-users
      # must live here (nix.custom.conf) to survive. Without it the daemon drops
      # every extra substituter as untrusted.
      trusted-users = [
        "root"
        "archismanmridha"
      ];

      extra-substituters = [ "https://devenv.cachix.org" ];
      extra-trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
  };
}
