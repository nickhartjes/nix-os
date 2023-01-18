require'nvim-treesitter.configs'.setup {

  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,

  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "help" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  parser_install_dir = "~/.config/nvim-parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)

    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
