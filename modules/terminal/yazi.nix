{
lib,
pkgs,
...
}:{
	programs.yazi = {
  		enable = true;
			package = pkgs.unstable.yazi;
			enableZshIntegration = true;
			catppuccin.enable = true;
			settings = {
				manager = {
					sort_by = "natural";
					show_symlink = true;
				};
				opener = {
					edit = [
						{ 
							run = "hx \"$@\"";
							block = true;
						}
					];
				};
				
			};
	};
}
