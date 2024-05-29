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

  gtk = {
  	enable = true;
	catppuccin = {
		enable = true;
		accent = "lavender";
		size = "standard";
		tweaks = [ "normal" ];
	};
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
	###
	# General
	###

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
	file
	pipx
	ripgrep
	killall
	wmname
	xorg.xev
	wget
	feh


	###
	# Aesthetics
	###

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
	ssh-audit
	unstable.rdwatool
	# trevorspray
	# cewler
	# shortscan

	### 
	# BurpSuite Stuff
	###
	(unstable.burpsuite.override {
		proEdition = true;
	})
	jython



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
	'';
	
  };

  # Firefox
  programs.firefox = {
  	enable = true;
	profiles.crem = {
		extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
			temporary-containers
			foxyproxy-standard
			firefox-color
			multi-account-containers
		];
	};
  };

  programs.zellij = {
  	enable = true;
	catppuccin.enable = true;
	settings = {
		themes = {
			custom-catuppuccin-mocha = {
				bg = "#585b70";
          			fg = "#cdd6f4";
				red = "#f38ba8";
				green = "#b4befe";
				blue = "#89b4fa";
				yellow = "#f9e2af";
				magenta = "#f5c2e7";
				orange = "#fab387";
				cyan = "#89dceb";
				black = "#181825";
				white  = "#cdd6f4";
			};
		};
	};
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

  programs.zsh = {
  	enable = true;
	enableCompletion = true;
	autocd = true;
	enableAutosuggestions = true;
	history = {
		extended = true;
		ignoreAllDups = true;
	};
	syntaxHighlighting = {
		enable = true;
		catppuccin.enable = true;
	};
	initExtra = ''
		bindkey '^[[1;5C' emacs-forward-word
		bindkey '^[[1;5D' emacs-backward-word
	'';

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
  home.stateVersion = "23.11";
}
