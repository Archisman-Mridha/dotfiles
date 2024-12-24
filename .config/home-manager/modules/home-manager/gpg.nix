{ config, ... }:

let
  uid = builtins.toString config.users.users.${config.home.username}.uid;
in
{
  programs.gpg = {
    enable = true;
    settings = {
      /* Key server */
      "auto-key-locate" = "keyserver";
      "keyserver" = "hkps://hkps.pool.sks-keyservers.net";
      "keyserver-options" = "no-honor-keyserver-url";

      /* Cipher preferences */
      "personal-cipher-preferences" = "AES256 AES192 AES CAST5";
      "personal-digest-preferences" = "SHA512 SHA384 SHA256 SHA224";
      "default-preference-list" = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
      "cert-digest-algo" = "SHA512";
      "s2k-cipher-algo" = "AES256";
      "s2k-digest-algo" = "SHA512";

      /* Other settings */
      "charset" = "utf-8";
      "fixed-list-mode" = true;
      "no-comments" = true;
      "no-emit-version" = true;
      "keyid-format" = "0xlong";
      "list-options" = "show-uid-validity";
      "verify-options" = "show-uid-validity";
      "with-fingerprint" = true;
      "use-agent" = true;
      "require-cross-certification" = true;
    };
  };

  /* Dirmngr configuration */
  home.file.".gnupg/dirmngr.conf".text = ''
    keyserver hkp://jirk5u4osbsr34t5.onion
    keyserver hkp://keys.gnupg.net
    honor-http-proxy
    hkp-cacert /etc/sks-keyservers.netCA.pem
  '';

	/* GPG agent configuration */
	home.file.".gnupg/gpg-agent.conf".text = ''
		pinentry-program /opt/homebrew/bin/pinentry-mac
		enable-ssh-support
		default-cache-ttl 600
		max-cache-ttl 7200
	'';

	/* services = {
		gpg-agent = {
			enable = true;
			enableZshIntegration = true;
			enableSshSupport = true;
			enableExtraSocket = true;

			maxCacheTtl = 7200;
			defaultCacheTtl = 600;
		};
	}; */
}
