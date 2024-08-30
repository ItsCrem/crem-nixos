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
    ../../modules/general
    ../../modules/hacker-pkgs
    ../../modules/terminal
    ../../modules/aesthetics
  ];

  home = {
    username = "crem";
    homeDirectory = "/home/crem";
    pointerCursor = {
    	#x11.enable = true;
      package = pkgs.google-cursor;
      name = "GoogleDot-White";
      size = 16;
    };
  };

  gtk = {
  	enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  # lorri
  services.lorri.enable = true;

  # Catpuccin
  catppuccin.flavor = "mocha";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
