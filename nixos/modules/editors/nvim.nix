#
# Neovim
#

{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = false;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        #packer-nvim
        #telescope-nvim
#        nvim-treesitter.withPlugins (p: [ p.c p.java p.lua p.typescript p.vim p.help p.javascript p.rust p.go p.python ])
        #nvim-treesitter
        #harpoon

        #rose-pine

        # Syntax
#        vim-nix
#        vim-markdown
#
#        # Quality of life
#        vim-lastplace         # Opens document where you left it
#        auto-pairs            # Print double quotes/brackets/etc.
#        vim-gitgutter         # See uncommitted changes of file :GitGutterEnable
#
#        # File Tree
#	      nerdtree              # File Manager - set in extraConfig to F6
#
#        # Customization
#        wombat256-vim         # Color scheme for lightline
#        srcery-vim            # Color scheme for text
#
#        lightline-vim         # Info bar at bottom
#	      indent-blankline-nvim # Indentation lines
      ];

#      extraConfig = ''
#        syntax enable                             " Syntax highlighting
#        colorscheme srcery                        " Color scheme text
#
#        let g:lightline = {
#          \ 'colorscheme': 'wombat',
#          \ }                                     " Color scheme lightline
#
#        highlight Comment cterm=italic gui=italic " Comments become italic
#        hi Normal guibg=NONE ctermbg=NONE         " Remove background, better for personal theme
#
#        set number                                " Set numbers
#
#        nmap <F6> :NERDTreeToggle<CR>             " F6 opens NERDTree
#      '';
    };
  };
  home.packages = with pkgs; [       # Packages installed
    ripgrep # For use with nvim
    fd      # For use with nvim
  ];
}

