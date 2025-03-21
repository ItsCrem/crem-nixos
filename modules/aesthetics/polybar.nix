{
inputs,
outputs,
lib,
...
}:{
    services.polybar = {
    	enable = true;
   		script = "/home/crem/Documents/dots/nix/polybar.config.ini";
  };
}