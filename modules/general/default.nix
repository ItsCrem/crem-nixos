{
lib,
input,
pkgs,
...
}:{

imports = [
    ./firefox.nix
    ./git.nix
    ./linux-utils.nix
    ./programming-languages.nix
    ./random.nix
    ./vscode.nix
	];
}


