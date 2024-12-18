{
lib,
pkgs,
config,
...
}:{
	options = {
		web-app.enable =
			lib.mkEnableOption "enables web-app";
	};

	config = lib.mkIf config.web-app.enable {
	# All packages used for web-app assessments
		home.packages = with pkgs; [
            ffuf
            padre
            wfuzz
            kiterunner
            jsluice
            gospider
						(unstable.burpsuite.override {
							proEdition = true;
						})
						(callPackage ../../pkgs/smugglefuzz/package.nix {})
						(callPackage ../../pkgs/sourcemapper/package.nix {})
        ];

	};
}
