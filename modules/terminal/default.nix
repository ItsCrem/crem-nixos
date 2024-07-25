{
lib,
input,
...
}:{

imports = [	
	./alacritty.nix
	./bat.nix
	./fzf.nix
	./helix.nix
	./kitty.nix
	./neovim.nix
	./starship.nix
	./yazi.nix
	./zsh.nix
	];

neovim.enable = lib.mkDefault false;
	
}
