# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.unstable-packages
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  boot.initrd.luks.devices."luks-825b4b6f-c7b3-4a23-87a4-e243f7b74643".device = "/dev/disk/by-uuid/825b4b6f-c7b3-4a23-87a4-e243f7b74643";
  networking.hostName = "brook"; # Define your hostname.
  networking.nameservers = ["1.1.1.1" "1.0.0.1" ];

  environment.localBinInPath = true;
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Framework Firmware

  services.fwupd.enable = true;
  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  services.fwupd.package = (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
    sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
  }) {
    inherit (pkgs) system;
  }).fwupd;

  services.fprintd.enable = true;
  
  # Enable networking
  networking.networkmanager.enable = true;

  # Enable docker daemon
  virtualisation.docker.enable = true;

  # Disable firewall
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  programs.zsh.enable = true;

  # 1password requires nixos level https://1password.community/discussion/comment/655813/#Comment_655813
  programs._1password = {
    enable = true;
    package = pkgs.unstable._1password;
  };
  programs._1password-gui = {
    package = pkgs.unstable._1password-gui;
    enable = true;
    polkitPolicyOwners = [ "crem" ];
  };
  # 1password make fingerprintn auth work
  #security.pam.services.kwallet.enableKwallet = true;
  security.polkit.enable = true;

  # proxychains configuration
  programs.proxychains = {
    enable = true;
    proxies = {
      tooling = {
        type = "socks4";
        host = "127.0.0.1";
        port = 8060;
        enable = true;
      };
    };
  };

  # lorri / direnv
  services.lorri.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.crem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "crem";
    extraGroups = [ "networkmanager" "wheel" "input" "docker"];
    packages = with pkgs; [
    #  thunderbird
      home-manager
      kitty
      firefox
      fprintd
      polkit_gnome
    ];
  };

  # Fonts
  fonts = {
	enableDefaultPackages = true;
	packages = with pkgs; [
		font-awesome
    nerdfonts
		dejavu_fonts
		noto-fonts-cjk
    inter
    jetbrains-mono
	];

	fontconfig = {
		defaultFonts = {
			serif = [ "DejaVu Sans" ];
			sansSerif = [ "Deja Serif" ];
			monospace = [ "JetBrainsMono Nerd Font Mono" ];
		};
	};
  };

    # Stylix
  stylix = {
  	base16Scheme = {
  		base00 = "1e1e2e"; # base
  		base01 = "181825"; # mantle
  		base02 = "313244"; # surface0
  		base03 = "45475a"; # surface1
  		base04 = "585b70"; # surface2
  		base05 = "cdd6f4"; # text
  		base06 = "f5e0dc"; # rosewater
  		base07 = "b4befe"; # lavender
  		base08 = "f38ba8"; # red
  		base09 = "fab387"; # peach
  		base0A = "f9e2af"; # yellow
  		base0B = "a6e3a1"; # green
  		base0C = "94e2d5"; # teal
  		base0D = "89b4fa"; # blue
  		base0E = "cba6f7"; # mauve
  		base0F = "f2cdcd"; # flamingo
  	};
  	image = "";
  	polarity = "dark";
  	cursor = {
  		package = pkgs.google-cursor;
  		name = "GoogleDot-White";
  		size = 16;
	  };
  };
  
  # Hyprland
  programs.hyprland.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

}
