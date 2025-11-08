{
  # Let Determinate Nix handle Nix configuration.
  nix.enable = false;

  services = {
    nix-daemon = {
      # Whether to make the nix-daemon service socket activated.
      enableSocketListener = true;
    };
  };
}
