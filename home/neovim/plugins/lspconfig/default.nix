{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.nvim-lspconfig;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
  pkgs.vimPlugins.blink-cmp
]
