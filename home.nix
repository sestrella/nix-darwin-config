{ pkgs, ... }:

{
  imports = [
    ./home/direnv
    ./home/fish
    ./home/ghci
    ./home/git
    ./home/gnome
    ./home/google-chrome
    ./home/starship
    ./home/tmux
    ./home/vim
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

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
  # home.stateVersion = "20.09";

  home.packages = with pkgs; [
    bind
    file
    gitAndTools.gh
    htop
    jq
    lsof
    ncat
    ngrok
    niv
    ripgrep
    slack
    spotify
    tmate
    xclip
    zoom-us
  ];

  # fonts.fontconfig.enable = true;

  # services.gpg-agent ={
  #   enable = true;
  #   enableSshSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  news.display = "silent";
}
