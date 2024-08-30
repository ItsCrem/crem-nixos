{
inputs,
outputs,
lib,
pkgs,
...
}:{

		programs.helix = {
			enable = true;
			# will define in toml file
	  };

		# nix language support
		home.packages = with pkgs; [
			# nix
			nil
			nixpkgs-fmt
			
			# python
			pyright
			python311Packages.python-lsp-server

			# bash
			unstable.bash-language-server

			# golang
			gopls

			# javascript / typescript
			unstable.typescript-language-server

			# typst
			typst-lsp
			unstable.tinymist

			# html/css/json
			vscode-langservers-extracted

			# markdown
			marksman
			
		]; 
	
}
