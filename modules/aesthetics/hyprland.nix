{
lib,
config,
pkgs,
...
}:{

wayland.windowManager.hyprland.settings = {
			enable = true;
	  };

programs.waybar = {
	enable = true;
};

programs.rofi = {
	enable = true;
	package = pkgs.rofi-wayland;
};

services.dunst = {
	enable = false;
	iconTheme = {
		package = pkgs.papirus-icon-theme;
		size = "64x64";
		name = "Paprius-Dark";
	};
	settings = {
		global = {
			origin = "top-center";
			corner_radius = 15;
			gap_size = 5;
			stack_duplicates = true;
			enable_recursive_icon_lookup = true;
			font = "JetBrainsMono Nerd Font Mono 9";
			format = "<b>%a</b>\\n<b>%s</b>\\n%b";
			#format = "%a\\n%b";
			width = 350;
			alignment = "center";
			icon_position = "left";
			min_icon_size = 64;
			max_icon_size = 64;
			show_indicators = false;
		};
	};
};

programs.hyprlock = {
	package = pkgs.hyprlock;
	enable = true;
};

programs.swaylock = {
	enable = true;
};

}


