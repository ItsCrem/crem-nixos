# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # VMWare
  services.xserver.videoDrivers = [ "vmware" ];
  virtualisation.vmware.guest.enable = true;
  
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

  networking.hostName = "kuma";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1"];

  # Add local bin to path
  environment.localBinInPath = true;
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";

  # Time Zone
  time.timeZone = "Australia/Sydney";

  programs.zsh.enable = true;
  
  users.users = {
    crem = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = ["wheel" "networkmanager"];
      packages = with pkgs; [
        git
        home-manager
		open-vm-tools
		bspwm
		sxhkd
		dig
    ];

    };
  };

  # Fonts
  fonts = {
	enableDefaultPackages = true;
	packages = with pkgs; [
		nerdfonts
		dejavu_fonts
		noto-fonts-cjk
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

  # Enable X11
  services.xserver = {
	enable = true;
	xkb.layout = "us";
	windowManager.bspwm = {
		enable = true;
		configFile = "/home/crem/Documents/dots/nix/bspwm/bspwmrc";
		sxhkd.configFile = "/home/crem/Documents/dots/nix/sxhkd/sxhkdrc"; 
	};
  };

  services.displayManager.defaultSession = "none+bspwm";
  
  # Gnome Display Manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
