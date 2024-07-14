{
inputs,
outputs,
lib,
...
}:{

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
}
