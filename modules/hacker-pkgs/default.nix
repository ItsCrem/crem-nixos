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
    external.enable = lib.mkDefault true; 
    internal.enable = lib.mkDefault true; 
    oscp-banned.enable = lib.mkDefault true; 
    web-app.enable = lib.mkDefault true; 
    wifi.enable = lib.mkDefault true; 
}
