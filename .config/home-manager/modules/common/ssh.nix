{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    enableDefaultConfig = false;

    includes = [ "assh.config" ];
  };

  home.file.".ssh/assh.d/personal.yaml".text = ''
    hosts:
      gitea.obmondo.com:
        HostName: gitea.obmondo.com
        Port: 2223

      github.com:
        HostName: github.com
        IdentityFile: /Users/archismanmridha/.ssh/github
  '';
}
