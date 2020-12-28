{ pkgs, config, ... }:

let
  niv = import (import ./nix/sources.nix {}).niv {};
in {
  imports = [
    ./home/fish
    ./home/git
    ./home/gnome
    ./home/google-chrome
    ./home/neovim
    ./home/spotify
    ./home/starship
    ./home/tmux
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/home/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

  home.packages = [
    niv.niv
    pkgs.jq
    pkgs.nix-linter
    pkgs.slack
    pkgs.xclip
    pkgs.zoom-us
  ];

  news.display = "silent";

  systemd.user = {
    services = {
      "home-manager-gc" = {
        Unit = {
          Description = "home-manager garbage collector";
        };
        Service = {
          WorkingDirectory = "${config.home.homeDirectory}/.config/nixpkgs";
          ExecStart = ''
            /run/current-system/sw/bin/nix-shell --run "home-manager expire-generations \"-2 days\""
          '';
        };
        Install = {
          WantedBy = [
            "default.target"
          ];
        };
      };
      "home-manager-updater" = {
        Unit = {
          Description = "home-manager updater";
        };
        Service = {
          WorkingDirectory = "${config.home.homeDirectory}/.config/nixpkgs";
          ExecStartPre = "${config.home.homeDirectory}/.nix-profile/bin/niv update";
          ExecStart = "/run/current-system/sw/bin/nix-shell --run 'home-manager switch'";
        };
        Install = {
          WantedBy = [
            "default.target"
          ];
        };
      };
    };
    timers = {
      "home-manager-gc" = {
        Unit = {
          Description = "Weekly home-manager garbage collector";
        };
        Timer = {
          OnCalendar = "weekly";
          Persistent = true;
        };
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
      };
      "home-manager-updater" = {
        Unit = {
          Description = "Weekly home-manager updater";
        };
        Timer = {
          OnCalendar = "weekly";
          Persistent = true;
        };
        Install = {
          WantedBy = [
            "timers.target"
          ];
        };
      };
    };
  };
}
