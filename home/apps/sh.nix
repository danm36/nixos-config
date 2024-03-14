{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ".." = "cd ..";
      "cd" = "z";
    };
    initExtra = ''
      neofetch
      '';
  };
}
