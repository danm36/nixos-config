{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
    };
  };
}
