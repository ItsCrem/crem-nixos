{
lib,
config,
pkgs,
...
}:{

wayland.windowManager.hyprland.settings = {
			enable = true;
			catppuccin.enable = true;
			catppuccin.accent = "lavender";		
	  };

programs.waybar = {
	enable = true;
	catppuccin = {
		enable = true;
		mode = "createLink";
	};
};

programs.rofi = {
	enable = true;
	package = pkgs.rofi-wayland;
};

programs.hyprlock = {
	enable = true;
};

}


