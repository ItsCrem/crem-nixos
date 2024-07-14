{
lib,
input,
...
}:{

imports = [
    ./all-purpose.nix
    ./external.nix
    ./internal.nix
    ./oscp-banned.nix
    ./web-app.nix
	./wifi.nix
	];

    # TODO: split home configs so no need it can be configured per config.
    external.enable = true;
    internal.enable = true;
    oscp-banned.enable = true;
    web-app.enable = true;
    wifi.enable = false;
}
