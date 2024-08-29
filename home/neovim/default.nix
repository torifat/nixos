{
  lib,
  pkgs,
  config,
  ...
}:

let
  lazy-nix-helper-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lazy-nix-helper.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "b-src";
      repo = "lazy-nix-helper.nvim";
      rev = "v0.4.0";
      sha256 = "TBDZGj0NXkWvJZJ5ngEqbhovf6RPm9N+Rmphz92CS3Q=";
    };
  };

  sanitizePluginName =
    input:
    let
      name = lib.strings.getName input;
      intermediate = lib.strings.removePrefix "vimplugin-" name;
      result = lib.strings.removePrefix "lua5.1-" intermediate;
    in
    result;

  pluginList =
    plugins:
    lib.strings.concatMapStrings (
      plugin: "  [\"${sanitizePluginName plugin.name}\"] = \"${plugin.outPath}\",\n"
    ) plugins;

in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    CC = "zig cc";
    CXX = "zig c++";
  };

  home.packages = with pkgs; [
    fd
    fzf
    ripgrep
    prettierd
    # Build
    clang
    zig
    cargo
  ];

  stylix.targets.neovim.enable = false;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nix-helper-nvim
      lazy-nvim
      nvim-treesitter
    ];

    extraLuaConfig = ''
      local plugins = {
      ${pluginList config.programs.neovim.plugins}
      }
      local lazy_nix_helper_path = "${lazy-nix-helper-nvim}"
      -- add the Lazy Nix Helper plugin to the vim runtime
      vim.opt.rtp:prepend(lazy_nix_helper_path)

      -- call the Lazy Nix Helper setup function
      local non_nix_lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      local lazy_nix_helper_opts = { lazypath = non_nix_lazypath, input_plugin_table = plugins }
      require("lazy-nix-helper").setup(lazy_nix_helper_opts)

      -- get the lazypath from Lazy Nix Helper
      local lazypath = require("lazy-nix-helper").lazypath()
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable", -- latest stable release
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      require("config.lazy")
    '';
  };

  # xdg.configFile = {
  #   "nvim" = {
  #     source = ./lazyvim;
  #     recursive = true;
  #   };
  # };
}
# vim:et:sw=2:ts=2:sta:nu
