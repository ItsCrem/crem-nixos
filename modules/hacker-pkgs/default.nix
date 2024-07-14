{
lib,
input,
...
}:{

imports = [
    ./all-purpose.nix
    ./external.nix
    ./internal.nix
    ./web-app.nix
	./wifi.nix
	];

    # TODO: split home configs so no need it can be configured per config.
    wifi.enable = false;
    external.enable = true;
    internal.enable = true;
    web-app.enable = true;
}
