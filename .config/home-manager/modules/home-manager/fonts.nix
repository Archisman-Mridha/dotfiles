{ pkgs, ... }:
let
	fontsDir =
		if pkgs.stdenv.isDarwin then
    	"~/Library/Fonts"
  	else
    	"~/.local/share/fonts";

	monacoNerdFont = pkgs.stdenv.mkDerivation {
		name = "monaco-nerd-font";
		version = "latest";

		src = pkgs.fetchgit {
			url = "https://github.com/thep0y/monaco-nerd-font.git";
			rev = "HEAD";
			sha256 = "sha256-J1kH0a7BASf3T/eTn+GY/T2Uj49Rp7XRD3H/3VGzLgk=";
		};

		installPhase = ''
			cp -r $src $TMPDIR/monaco-nerd-font
    	cd $TMPDIR/monaco-nerd-font/ligaturized

			rm *Italic.ttf

			mkdir -p $out/share/fonts
			cp -r ./* $out/share/fonts
		'';
	};
in {
	home.packages = [
		monacoNerdFont
	];
}
