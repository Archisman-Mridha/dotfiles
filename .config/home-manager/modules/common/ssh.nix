{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
      };

      "gitea.obmondo.com" = {
        hostname = "gitea.obmondo.com";
        port = 2223;
      };

      /*
        "lima-default" = {
          hostname = "127.0.0.1";
          port = 52907;
          user = "archismanmridha";
          identityFile = "~/.lima/_config/user";
          extraOptions = {
            StrictHostKeyChecking = "no";
            UserKnownHostsFile = "/dev/null";
            NoHostAuthenticationForLocalhost = "yes";
            PreferredAuthentications = "publickey";
            Compression = "no";
            BatchMode = "yes";
            IdentitiesOnly = "yes";
            Ciphers = "^aes128-gcm@openssh.com,aes256-gcm@openssh.com";
            ControlMaster = "auto";
            ControlPath = "/Users/archismanmridha/.lima/default/ssh.sock";
            ControlPersist = "yes";
          };
        };
      */
    };

    # includes = [ "assh.config" ];
  };
}
