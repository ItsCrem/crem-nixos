{
pkgs,
...
}:{
	home.packages = with pkgs; [
        #python3
        go
        rustup
				unstable.typst
				(python312.withPackages (ppkgs: [
					ppkgs.requests
					ppkgs.tomli
					ppkgs.watchdog
				]))
    ];
}
