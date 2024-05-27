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

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
    	outputs.overlays.unstable-packages
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

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
 

  # Cursor GTK
  #x11 = {
  #	enable = true;
  #	cursorTheme = {
  #		package = pkgs.google-cursor;
  #		name = "GoogleDot-White";
  #		size = 16;
  #	};
  #};

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
	###
	# General
	###

	neovim
	neofetch
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

	###
	# Aesthetics
	###

	rofi
	starship
	polybar
	google-cursor

	###
	# Security - General
	###

	seclists


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


	###
	# External
	###

	sqlmap
	sslscan
	ffuf
	gobuster
	feroxbuster
	nuclei
	httpx
	padre
	gau
	findomain
	subfinder
	dnsx
	amass
	wfuzz
	gowitness
	masscan
	unstable.rdwatool
	(unstable.burpsuite.override {
		proEdition = true;
	})
	# trevorspray
	# cewler
	# shortscan
	
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

  # Firefox
  programs.firefox = {
  	enable = true;
	#profiles.crem = {
	#	extensions = with pkgs.inputs.firefox-addons; [
	#		ublock-origin
	#	];
	#};
  };


  programs.bat.enable = true;
  programs.fzf = {
  	enable = true;
	enableZshIntegration = true;
  };

  programs.zsh = {
  	enable = true;
	enableCompletion = true;
	enableAutosuggestions = true;
	history.extended = true;
  };

  programs.starship = {
	enable = true;
  };

  programs.alacritty = {
  	enable = true;
	# shell.program = "/home/crem/.nix-profile/bin/zsh";
	settings = {
		colors.normal.black = "#45475a";
		colors.normal.red = "#f38ba8";
		colors.normal.green = "#a6e3a1";
		colors.normal.yellow = "#f9e2af";
		colors.normal.blue = "#89b4fa";
		colors.normal.magenta = "#f5c2e7";
		colors.normal.cyan = "#94e2d5";
		colors.normal.white = "#bac2de";
		colors.bright.black = "#585b70";
		colors.bright.red = "#f38ba8";
		colors.bright.green = "#a6e3a1";
		colors.bright.yellow = "#f9e2af";
		colors.bright.blue = "#89b4fa";
		colors.bright.magenta = "#f5c2e7";
		colors.bright.cyan = "#94e2d5";
		colors.bright.white = "#a6adc8";
		colors.primary.background = "#1e1e2e";
		colors.primary.foreground = "#cdd6f4";		
		font.size = 11;
		window = {
			padding.x = 20;
			padding.y = 10;
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
  home.stateVersion = "23.11";
}
