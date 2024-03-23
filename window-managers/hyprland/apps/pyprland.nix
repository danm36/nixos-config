{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "pypr"
      "pavucontrol"
    ];

    bind = [
      "SUPER, Z, exec, pypr toggle term && hyprctl dispatch bringactivetotop"
      "SUPER, P, exec, pypr toggle btop && hyprctl dispatch bringactivetotop"
      "SUPER, E, exec, pypr toggle thunderbird && hyprctl dispatch bringactivetotop"
      "SUPER, V, exec, pypr toggle pavucontrol && hyprctl dispatch bringactivetotop"

      "SUPER, code:21, exec, pypr zoom" # code:21 is the += key
    ];

    "$scratchpadsize" = "size 80% 85%";
    "$scratchpad" = "class:^(scratchpad)$";
    "$thunderbirdscratchpad" = "class:^(thunderbird)$";
    "$pavucontrol" = "class:^(pavucontrol)$";

    windowrulev2 = [
      "float,$scratchpad"
      "$scratchpadsize,$scratchpad"
      "workspace special silent,$scratchpad"
      "center,$scratchpad"

      "float,$thunderbirdscratchpad"
      "$scratchpadsize,$thunderbirdscratchpad"
      "workspace special silent,$thunderbirdscratchpad"
      "center,$thunderbirdscratchpad"

      "float,$pavucontrol"
      "size 60% 40%,$pavucontrol"
      "move 50% 6%,$pavucontrol"
      "workspace special silent,$pavucontrol"
      "opacity 0.80,$pavucontrol"
    ];
  };

  home.packages = with pkgs; [
    (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "2.0.9";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-dyuqLjh6q+TyQLz0Kqjx+QeGuC0FB1dyt3lH5CYFsZA=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.aiofiles
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })
  ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
      "lost_windows",
      "magnify",
      "expose",
    ]

    [expose]
    include_special = false

    [scratchpads.term]
    command = "kitty --class scratchpad"
    margin = 50
    animation = "fromTop"
  
    [scratchpads.btop]
    command = "kitty --class scratchpad -e btop"
    margin = 50
    animation = "fromTop"

    [scratchpads.thunderbird]
    command = "thunderbird"
    margin = 50
    animation = "fromTop"

    [scratchpads.pavucontrol]
    command = "pavucontrol"
    margin = 50
    unfocus = "hide"
    animation = "fromTop"
    
  '';
}