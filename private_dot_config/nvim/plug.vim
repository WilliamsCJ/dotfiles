call plug#begin('~/.config/nvim/plugged')
     " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " File Explorer
    Plug 'scrooloose/NERDTree'
    
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'

    " Language Server Protocol
    Plug 'neovim/nvim-lspconfig'

    " LSP Saga UI 
    Plug 'glepnir/lspsaga.nvim'

    " Nord theme
    Plug 'arcticicestudio/nord-vim'

    " Lualine
    Plug 'nvim-lualine/lualine.nvim'

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
