{ 
config,
lib,
pkgs,
inputs,
... 
}:{
	programs.firefox = {
  		enable = true;
		policies = {
			"CaptivePortal" = false;
			"DisablePocket" = true;
			"DisableTelemetry" = true;
		};
		profiles.crem = {
			extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
				temporary-containers
				foxyproxy-standard
				firefox-color
				multi-account-containers
				sidebery
			];
		};
  	};
}
