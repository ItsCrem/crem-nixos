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
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
	###
	# General
	###

	neovim
	neofetch
	fzf
	python3
	go
	rustup
	zsh
	krb5
	docker
	vscode
	alacritty

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

  #stylix.cursor.package = pkgs.google-cursor;
  #stylix.cursor.name = "GoogleDot-White";

  #stylix.fonts = {
  #  monospace = {
  #    package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
  #    name = "JetBrainsMono Nerd Font Mono";
  #  };
  #  sansSerif = {
  #    package = pkgs.dejavu_fonts;
  #    name = "DejaVu Sans";
  #  };
  #  serif = {
  #    package = pkgs.dejavu_fonts;
  #    name = "DejaVu Serif";
  #  };
  #};

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
