{
lib,
pkgs,
...
}:{
	programs.yazi = {
  		enable = true;
			enableZshIntegration = true;
			catppuccin.enable = true;
	};
}
