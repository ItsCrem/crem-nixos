{
lib,
pkgs,
config,
...
}:{
	options = {
		external.enable =
			lib.mkEnableOption "enables external";
	};

	config = lib.mkIf config.external.enable {
	# All packages used for external assessments
		home.packages = with pkgs; [
            sslscan
            tlsx
            ffuf
            gobuster
            feroxbuster
            nuclei
            httpx
            cent
            padre
            gau
            findomain
            subfinder
            dnsx
            amass
            wfuzz
            gowitness
            masscan
            ssh-audit
            kiterunner
            rustscan
            swaks
            jsluice
            gospider
            unstable.ntlm-challenger

            # TODO: Not found
            # trevorspray - https://github.com/blacklanternsecurity/TREVORspray
            # shortscan - https://github.com/bitquark/shortscan
        ];
	};
}
