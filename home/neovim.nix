args@{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.lua-language-server
      pkgs.nodePackages.bash-language-server
      pkgs.pyright
      pkgs.rnix-lsp
      pkgs.stylua
      pkgs.terraform-ls
      pkgs.yaml-language-server
    ];
    extraLuaConfig = builtins.readFile ./neovim/extra-config.lua;
    plugins = builtins.concatLists
      (map (plugin: import plugin args) [
        ./neovim/plugins/auto-dark-mode.nix
        ./neovim/plugins/cmp.nix
        ./neovim/plugins/comment.nix
        ./neovim/plugins/hardtime.nix
        ./neovim/plugins/lspconfig.nix
        ./neovim/plugins/lualine.nix
        ./neovim/plugins/null-ls.nix
        ./neovim/plugins/solarized.nix
        ./neovim/plugins/telescope.nix
        ./neovim/plugins/which-key.nix
        ./neovim/plugins/whitespace.nix
      ]);
    vimdiffAlias = true;
  };

  programs.fish.shellAbbrs = {
    vi = "nvim";
    vim = "nvim";
  };
}
