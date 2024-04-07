{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home = {
    username = "archismanmridha";
    homeDirectory = "/Users/archismanmridha";

    # This value determines the Home Manager release that your configuration is compatible with. This
    # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
    # You should not change this value, even if you update Home Manager. If you do want to update
    # the value, then make sure to first check the Home Manager release notes.
    stateVersion = "23.11";

    # Home Manager is pretty good at managing dotfiles. The primary way to manage plain files is
    # through home.file.
    file = { };

    # Home Manager can also manage your environment variables through home.sessionVariables. If you
    # don't want to manage your shell through Home Manager then you have to manually source
    # hm-session-vars.sh located at any one of these location :
    # (1) ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # (2) ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    # (3) /etc/profiles/per-user/archismanmridha/etc/profile.d/hm-session-vars.sh
    sessionVariables = { };
  };

  # This option allows you to install Nix packages into your environment.
  home.packages = [ ];
  imports = [
    ./packages.nix
  ];
}
