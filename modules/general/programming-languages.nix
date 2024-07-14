{
inputs,
outputs,
lib,
pkgs,
...
}:{
	home.packages = with pkgs; [
        python3
        go
        rustup
    ];
}