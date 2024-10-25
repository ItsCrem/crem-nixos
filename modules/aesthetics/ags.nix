{
inputs,
outputs,
lib,
pkgs,
...
}:{
    programs.ages = {
        enable = true;

        extraPackages = with pkgs; [
          gtksourceview
          webkitgtk
          accountsservice
    ];
  };
}
