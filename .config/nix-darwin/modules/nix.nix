{
  # Auto upgrade nix packages and the daemon service
  nix = {
    enable = true;

    # Automatically run the nix store optimiser at a specific time.
    optimise = {
      automatic = true;
      interval = {
        Hour = 23;
      };
    };

    # Automatically run the garbage collector at a specific time.
    gc = {
      automatic = true;
      interval = {
        Hour = 23;
      };
    };
  };

  services = {
    nix-daemon = {
      # Whether to make the nix-daemon service socket activated.
      enableSocketListener = true;
    };
  };
}
