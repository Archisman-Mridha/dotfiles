{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = { };
    casks = [
      "vlc"
      "discord"
      "aviatrix-vpn-client"
      "sourcetrail"
    ];
    taps = [ ];
    brews = [
      "kube-ps1"
      "riscv64-elf-gdb"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
