{
inputs,
outputs,
lib,
pkgs,
...
}:{
	programs.vscode = {
		enable = true;
		package = pkgs.vscode;
		extensions = with pkgs.vscode-extensions; [
			ms-python.python
			catppuccin.catppuccin-vsc
			esbenp.prettier-vscode
			pkief.material-icon-theme
			jnoortheen.nix-ide
		];
		userSettings = {
		 	"workbench.iconTheme" = "material-icon-theme";
		 	"workbench.colorTheme" = "Catppuccin Mocha Bordered";
		 	"terminal.integrated.defaultProfile.linux" = "zsh";
		 	"nix.enableLanguageServer" = true;
		};	
  	};
}
