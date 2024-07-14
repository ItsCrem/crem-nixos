# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
	inputs.catppuccin.homeManagerModules.catppuccin

     ../modules/firefox.nix
	 ../modules/terminal.nix
  ];

  home = {
    username = "crem";
    homeDirectory = "/home/crem";
    pointerCursor = {
    	x11.enable = true;
	package = pkgs.google-cursor;
	name = "GoogleDot-White";
	size = 16;

    };
  };

  gtk = {
  	enable = true;
	#catppuccin = {
		#enable = true;
		#accent = "lavender";
		#size = "standard";
		#tweaks = [ "normal" ];
	#};
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
	###
	# General
	###

	neofetch
	(callPackage ../pkgs/cewler/package.nix {})
	(callPackage ../pkgs/ntlm-challenger/package.nix {})
	python3
	go
	rustup
	krb5
	docker
	vscode
	alacritty
	updog
	unzip
	zellij
	tmux
	file
	pipx
	ripgrep
	killall
	wmname
	xorg.xev
	wget
	feh
	google-chrome
	pwgen
	sqlite-web
	sqlite-utils
	jq
	exiftool
	binutils


	###
	# Aesthetics
	###

	starship
	polybar
	google-cursor
	zoxide

	###
	# Security - General
	###

	seclists
	inetutils
	cifs-utils
	freerdp
	net-snmp
	nfs-utils
	ntp
	openssh
	openvpn
	samba
	step-cli
	wireguard-go
	wireguard-tools
	xrdp
	go-exploitdb
	libgccjit
	awscli2


	###
	# Internal
	###
	python311Packages.impacket
	python311Packages.msldap
	python311Packages.lsassy
	python311Packages.pypykatz
	ldapdomaindump
	mitm6
	certipy
	responder
	unstable.netexec
	unstable.adidnsdump
	evil-winrm
	bloodhound-py
	fping
	nmap
	smbmap
	samba
	kerbrute
	coercer
	unstable.autobloody
	cewl
	postgresql_16
	#-- LDAP --#
	adenum
    msldapdump
    ldapmonitor
    ldapdomaindump
    ldapnomnom
    ldeep
    silenthound


	###
	# External
	###

	sqlmap
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
	unstable.rdwatool
	kiterunner
	rustscan
	swaks
	jsluice
	gospider
	# trevorspray
	# cewler
	# shortscan

	### 
	# BurpSuite Stuff
	###
	(unstable.burpsuite.override {
		proEdition = true;
	})



	###
	# Wi-Fi
	###

	wireshark
	#tshark
	airgeddon
	aircrack-ng
	bettercap
	#ettercap
	mdk4
	hcxdumptool
	hcxtools
	# dhcpd

  ];

  # Catpuccin
  catppuccin.flavor = "mocha";

  programs.neovim = {
	enable = true;
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;
	withPython3 = true;
	extraConfig = ''
		set number relativenumber
		set tabstop=4
		set shiftwidth=4 smarttab
	'';
	
  };

  programs.bat = {
	enable = true;
	catppuccin.enable = true;
  };  
  
  programs.fzf = {
  	enable = true;
	enableZshIntegration = true;
	catppuccin.enable = true;
  };

  programs.rofi = {
  	enable = true;
	catppuccin.enable = true;
  };

  services.polybar = {
    	enable = true;
    	catppuccin.enable = true;
   		script = "/home/crem/Documents/dots/nix/polybar.config.ini";
  };

  programs.starship = {
	enable = true;
	catppuccin.enable = true;
  };

  programs.alacritty = {
  	enable = true;
	catppuccin.enable = true;
	# shell.program = "/home/crem/.nix-profile/bin/zsh";
	settings = {
		font.size = 11;
		window = {
			padding.x = 20;
			padding.y = 20;
			decorations = "None";
		};
		env = {
			"TERM" = "xterm-256color";
		};
	};
  };


  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
