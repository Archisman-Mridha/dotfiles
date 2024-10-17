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
			sha256 = "sha256-+Z55U3dPb+wyjlSrJ447PlKkW9uyFpRFXDIB+OgORXI=";
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
