 { config, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    userName = userSettings.name;
    userEmail = userSettings.email;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      credential = {
        credentialStore = "secretservice";
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        "https://dev.azure.com" = {
          useHttpPath = true;
        };
      };
      pull = {
        rebase = "true";
      };
      push = {
        default = "simple";
      };
      rebase = {
        autostash = "true";
      };
    };
  };
}
