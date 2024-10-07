{
pkgs,
...
}:{
	home.packages = with pkgs; [
        neofetch
        git
        dig
        krb5
        docker
        updog
        feh
        google-chrome
        sqlite-web
        sqlite-utils
				unstable.ueberzugpp
				discord
				signal-desktop
				grimblast
				swappy
				blueman
				pavucontrol
				wlogout
				slack
				xorg.libxcvt
				obs-studio
				vlc
				papirus-icon-theme
				zathura
				python311Packages.tomli
				python311Packages.watchdog
				obsidian
				dconf
				wirelesstools
				usbutils
    ];
}
