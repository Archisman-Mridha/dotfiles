{ pkgs, ... }:
{
  programs.ssh = {
    enable = true;
    package = pkgs.openssh;

    enableDefaultConfig = false;

    includes = [ "assh.config" ];

    settings."*" = {
      /*
        NetBird runs with lazy connections, so it tears a peer tunnel down once the peer looks
        idle. OpenSSH, meanwhile, defaults to ServerAliveInterval 0, which means an idle session
        sends nothing at all. The two combine badly : an idle SSH session lets NetBird drop the
        tunnel underneath it, and then hangs, because nothing ever notices that the peer went
        away. Keepalives both keep the tunnel counted as active, and surface a genuinely dead
        one within a minute instead of blocking until the TCP timeout.
      */
      ServerAliveInterval = 15;
      ServerAliveCountMax = 4;
      TCPKeepAlive = true;

      /*
        Connection multiplexing is deliberately left off. It is tempting here, because every
        fresh connection to a NetBird peer re-runs `netbird ssh proxy` and its JWT check, but a
        master socket outlives the tunnel it was built on. Once the tunnel drops, every later
        session silently reuses the dead master and returns immediately, with no output and exit
        status 0, which is far worse than a slow reconnect : a script cannot tell that apart from
        success. Not worth it while the peer connection is this unstable.
      */
    };
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
