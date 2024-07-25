{
lib,
pkgs,
config,
...
}:{
	options = {
		wifi.enable =
			lib.mkEnableOption "enables wifi";
	};

	config = lib.mkIf config.wifi.enable {
	# All packages used for wifi assessments
		home.packages = with pkgs; [
			wireshark
			airgeddon
			aircrack-ng
			bettercap
			mdk4
			hcxdumptool
			hcxtools

			### TODO: Not found yet
			# dhcpd
			# tshark
			# ettercap
			];
	};
}
