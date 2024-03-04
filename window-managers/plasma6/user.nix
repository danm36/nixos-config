{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
    };
    panels = [
      {
        location = "bottom";
        alignment = "center";
        height = 32;
        widgets = [
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
        ];
      }
      {
        location = "top";
        height = 26;
        widgets = [
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };
}
