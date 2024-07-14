{
lib,
pkgs,
config,
...
}:{
	options = {
		oscp-banned.enable =
			lib.mkEnableOption "enables oscp-banned";
	};

	config = lib.mkIf config.oscp-banned.enable {
	# All packages that are banned for oscp exam
		home.packages = with pkgs; [
			sqlmap
        ];
	};
}
