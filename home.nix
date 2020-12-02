{ config, pkgs, ... }:

{
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
  home.stateVersion = "21.03";

  home.packages = [
    pkgs.bat
  ];

  programs.fish = {
    enable = true;
    # config
    promptInit = ''
      set -gx NIX_PATH $HOME/.nix-defexpr/channels $NIX_PATH
    '';
    shellAbbrs = {
      # git
      ga = "git add";
      gaa = "git add --all";
      gbr = "git branch --remote";
      gc = "git commit -v";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      # home-manager
      hmg = "home-manager generations";
      hmn = "home-manager news";
      hms = "home-manager switch";
    };
  };

  programs.git = {
    enable = true;
    # config
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastián Estrella";
  };

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      set colorcolumn=80
      set number

      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2

      set splitbelow
      set splitright

      set nobackup
      set noswapfile
      set noundofile

      colorscheme solarized

      let mapleader = "\<Space>"
      let maplocalleader = ','

      let g:airline_powerline_fonts = 1

      let g:NERDTreeShowHidden = 1

      noremap <C-n> :NERDTreeToggle<CR>
    '';
    plugins = with pkgs.vimPlugins; [
      bats-vim
      coc-nvim
      ctrlp-vim
      nerdcommenter
      nerdtree
      typescript-vim
      vim-airline
      vim-colors-solarized
      vim-jsx-typescript
      vim-nix
      vim-projectionist
      vim-trailing-whitespace
    ];
  };

  programs.starship.enable = true;
}
