{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
      };

      "gitea.obmondo.com" = {
        hostname = "gitea.obmondo.com";
        port = 2223;
      };
    };

    # includes = [ "assh.config" ];
  };
}
