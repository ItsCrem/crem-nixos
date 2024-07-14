{
inputs,
outputs,
lib,
...
}:{
    services.polybar = {
    	enable = true;
    	catppuccin.enable = true;
   		script = "/home/crem/Documents/dots/nix/polybar.config.ini";
  };
}